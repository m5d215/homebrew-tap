# Homebrew tap maintenance notes

Personal tap for [@m5d215](https://github.com/m5d215). Consumers install
via `brew tap m5d215/tap` + `brew install m5d215/tap/<formula>`.

## Formula shapes

Three shapes, each with a different release procedure. Match each
formula against one of them before editing.

### Shape A — external git tag (`agent-salon`)

Points at an upstream repo with `url "...git", tag: "vX.Y.Z"`. No
`sha256` — the git commit hash is the integrity check. Homebrew builds
from source at install time. See `Formula/agent-salon.rb`.

Release (manual): upstream tags `vX.Y.Z` → edit `tag:` in the formula →
commit + push the tap.

Release (automated): some upstreams bump the `tag:` line here
automatically on their own `v*` tag push, via a `.github/workflows/
release.yml` that uses a `TAP_PUSH_TOKEN` PAT to commit to this tap.
Currently enabled for `agent-salon`, `claude-history`, and
`claude-statusline`. PAT lifecycle (issue, register, renew, recover)
is handled by the `pat-renew` skill in `m5d215/agentic`.

### Shape B — tap-internal tarball (`agent-salon-restart`)

No upstream project — the formula itself *is* the deliverable (e.g. a
plist wrapper). `url` is a GitHub tarball against a tap-repo tag, with
an explicit `sha256`. See `Formula/agent-salon-restart.rb`.

Release (manual):
1. Bump `url` and `sha256` in the formula (sha256 via `curl -sL <tag
   tarball url> | shasum -a 256` — the tarball must exist first, so
   tag before this step).
2. Tag *this* repo: `<formula>-vX.Y.Z` (formula-scoped prefix; multiple
   Shape-B formulae can release independently).
3. Commit + push.

Release (automated): for formulae with a `.github/workflows/release-
<formula>.yml`, just push the `<formula>-vX.Y.Z` tag — the workflow
computes the sha256 from the tag tarball and bumps the formula on main.
Order inverts from manual: tag first, the bump commit lands after via
CI. Uses `GITHUB_TOKEN` (same-repo write), so no PAT is involved.
Currently enabled for `agent-salon-restart`.

### Shape C — upstream pre-built release binaries (`jq-jit`)

Upstream publishes per-platform binary tarballs on GitHub Releases.
Formula downloads the matching tarball with `on_macos { on_arm {...} }`
etc. and installs the extracted binary — no compilation. See
`Formula/jq-jit.rb`.

Release:
1. Confirm the release has assets for every platform the formula
   claims: `gh release view vX.Y.Z --repo m5d215/<project>`.
2. For each asset, `curl -sL <url> | shasum -a 256`.
3. Bump `version`, per-platform `url`, and per-platform `sha256`.
4. Commit + push.

## Gotchas (all actually hit)

**Audit rules** — run with `cp Formula/<name>.rb /opt/homebrew/Library/Taps/m5d215/homebrew-tap/Formula/ && brew audit --strict --new m5d215/tap/<name>`. (`brew audit` reads only from the tap clone, not arbitrary paths.)

- `version` is redundant when tarball URL ends in `vX.Y.Z.tar.gz` —
  drop it. Shape A/B usually don't need it; Shape C needs it because
  the asset filename omits the version.
- `version` must appear **before** `license`.
- "Empty installation" — formula must put at least one file in the
  cellar. For plist-only formulae (Shape B), write a README into
  `doc/` inside `install`. `prefix/"README.md"` does **not** count;
  use `doc/"README.md"`.
- `"#{bin}/foo"` in test block → use `bin/"foo"`.

**Service block (`service do`)**

- `run_type :cron` + `cron "<expr>"` generates `StartCalendarInterval`.
- Generated plist always includes `RunAtLoad true` — command also fires
  once on `brew services start`. No DSL opt-out.
- Filesystem paths referenced by the service (`working_dir`, DB under
  `var/`, logs under `var/log/`) must be pre-created in `post_install`
  with `(var/"<subdir>").mkpath`. Missing dirs → launchd `EX_CONFIG
  (78)` before the program runs. Verify with `launchctl print
  gui/$(id -u)/homebrew.mxcl.<name>`.
- Env vars in the service block are baked into the plist at install
  time → no per-host override without a wrapper script.
- Shape C (binary download) — do **not** list source-build deps like
  `depends_on "rust" => :build` at the top level; no compilation
  happens, it's pure overhead.

**Host operation**

- There is no `brew services log`. Use `brew services info <name>` to
  find the log path, then tail it.
- `brew services restart <name>` is the canonical "pick up formula
  changes" step after `brew upgrade`.
