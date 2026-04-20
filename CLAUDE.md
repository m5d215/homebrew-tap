# Homebrew tap maintenance notes

This tap hosts personal formulae for [@m5d215](https://github.com/m5d215).
Consumers install via:

```sh
brew tap m5d215/tap
brew install m5d215/tap/<formula>
```

## Repo layout

- `Formula/` — formula files. Each `<name>.rb` is installable as
  `m5d215/tap/<name>`.
- `README.md` — user-facing formula index.
- `CLAUDE.md` — this file. Release / update procedures.

## Three formula shapes

Formulae in this tap fall into three categories with **different release
procedures**. Match each formula against the shape below before editing.

### Shape A — external source (`agent-salon`)

Points at an upstream repo (here: `m5d215/agent-salon`) with `url "...git"`
+ `tag:`. No `sha256` needed because git tags carry their own integrity
via the commit hash.

```ruby
url "https://github.com/m5d215/agent-salon.git",
    tag: "v0.2.0"
```

**Release procedure** (when upstream cuts a new version):

1. In the upstream repo clone, bump `Cargo.toml` `version`, commit,
   tag, push:
   ```sh
   # already done by upstream workflow
   git tag -a v<X.Y.Z> -m "v<X.Y.Z>" <commit>
   git push origin v<X.Y.Z>
   ```
2. In this tap, bump the formula's `tag:` line and commit:
   ```sh
   # edit Formula/agent-salon.rb: tag: "v<X.Y.Z>"
   git add Formula/agent-salon.rb
   git commit -m "agent-salon: bump to v<X.Y.Z>"
   git push
   ```
3. On each host: `brew update && brew upgrade m5d215/tap/agent-salon`.

No sha256 recomputation — the git commit hash is the integrity check.

### Shape B — tap-internal source (`agent-salon-restart`)

No upstream project — the formula itself *is* the deliverable (a
launchd plist wrapper, a scheduled brew invocation, etc.). Uses a
GitHub archive tarball URL against a tap-repo tag, with an explicit
`sha256`.

```ruby
url "https://github.com/m5d215/homebrew-tap/archive/refs/tags/agent-salon-restart-v0.1.0.tar.gz"
sha256 "2d77536b0e7a57724c38194b28447d61a92b0c5c919979acb0287d89154ddc9f"
```

**Release procedure** (when the formula itself changes):

1. Tag *this* repo with a formula-scoped tag (prefix = formula name, so
   multiple shape-B formulae can release independently):
   ```sh
   git tag -a agent-salon-restart-v<X.Y.Z> -m "agent-salon-restart v<X.Y.Z>"
   git push origin agent-salon-restart-v<X.Y.Z>
   ```
2. Compute the tarball sha256 (GitHub archives are deterministic per
   tag):
   ```sh
   curl -sL https://github.com/m5d215/homebrew-tap/archive/refs/tags/agent-salon-restart-v<X.Y.Z>.tar.gz \
     | shasum -a 256
   ```
3. Update the formula:
   - bump the `url` tag
   - replace `sha256`
4. Commit and push the formula change:
   ```sh
   git add Formula/agent-salon-restart.rb
   git commit -m "agent-salon-restart: bump to v<X.Y.Z>"
   git push
   ```
5. On each host: `brew update && brew upgrade m5d215/tap/agent-salon-restart`.

Order matters — if you push the formula before the tag, the
`curl | shasum` will 404.

### Shape C — pre-built binary from upstream releases (`jq-jit`)

Upstream publishes platform-specific binary tarballs to GitHub Releases
(via CI). The formula downloads the tarball matching the current
platform and installs the extracted binary directly — no compilation,
install completes in seconds.

```ruby
version "1.1.1"

on_macos do
  on_arm do
    url "https://github.com/m5d215/jq-jit/releases/download/v1.1.1/jq-jit-macos-arm64.tar.gz"
    sha256 "<hash>"
  end
end

on_linux do
  on_intel do
    url "https://github.com/m5d215/jq-jit/releases/download/v1.1.1/jq-jit-linux-x86_64.tar.gz"
    sha256 "<hash>"
  end
end

def install
  bin.install "jq-jit"
end
```

**Release procedure** (when upstream ships a new release):

1. Confirm upstream CI has produced the expected binary assets:
   ```sh
   gh release view v<X.Y.Z> --repo m5d215/<project>
   ```
2. Compute the sha256 for each supported asset:
   ```sh
   curl -sL https://github.com/m5d215/<project>/releases/download/v<X.Y.Z>/<asset>.tar.gz \
     | shasum -a 256
   ```
3. Update the formula:
   - bump `version`
   - bump each `url` tag
   - replace each `sha256`
4. Commit and push:
   ```sh
   git add Formula/<name>.rb
   git commit -m "<name>: bump to v<X.Y.Z>"
   git push
   ```
5. On each host: `brew update && brew upgrade m5d215/tap/<name>`.

Notes on Shape C:
- `version` is **required** (explicit) — the release asset filename
  doesn't include the version, so Homebrew can't infer it. This bypasses
  the Shape-A/B audit rule about redundant version.
- Don't list `depends_on "rust" => :build` (or similar) at the top
  level — pre-built tarballs don't compile anything; declaring a build
  toolchain dep would make `brew install` unnecessarily pull it in.
- Use `on_macos { on_arm { ... } }` / `on_linux { on_intel { ... } }`
  blocks to pick the right asset. Platforms without a matching block
  will fail at install time — acceptable when no pre-built binary is
  available for that target.
- Audit requires `version` to appear *before* `license`, not after.

## Pre-push audit

Homebrew has a strict linter. Before pushing, sync your edited formula
into the active tap clone and audit:

```sh
cp Formula/<name>.rb /opt/homebrew/Library/Taps/m5d215/homebrew-tap/Formula/
brew audit --strict --new m5d215/tap/<name>
```

(`brew audit` can't read arbitrary paths; it only reads from the tap
directory under `/opt/homebrew/Library/Taps/`. Copying in first keeps
the iteration loop short without needing to push to trigger a re-tap.)

## Known audit rules

- **`version` is redundant with a tagged URL.** If the tarball URL ends
  in `vX.Y.Z.tar.gz` (Shape A or B), Homebrew scans the version from it;
  writing `version "X.Y.Z"` explicitly triggers a lint error.
- **"Empty installation" fails the build.** A formula must install at
  least one file into the cellar. For plist-only formulae (Shape B),
  write something into `doc/` (e.g. a README) inside the `install`
  block. `prefix.mkpath` + writing to `prefix/"README.md"` does **not**
  satisfy the check — use `doc.mkpath` + `doc/"README.md"`.

## Service block tips

- `service do` supports `run_type :cron` + `cron "<expr>"` for scheduled
  jobs. The generated plist uses `StartCalendarInterval`.
- Generated plists include `RunAtLoad <true/>` by default, which fires
  the command once at `brew services start` time *in addition* to the
  cron schedule. Usually fine (and often desirable). No opt-out via the
  DSL as of this writing.
- When a service needs filesystem paths (`working_dir`, DB files under
  `var/`, log files under `var/log/`), pre-create them in `post_install`
  with `(var/"<subdir>").mkpath`. Missing directories cause launchd to
  exit `EX_CONFIG (78)` before the program even runs.
- Env vars in the service block are set by launchd before exec, so they
  become hard to override per-host without editing the formula. If
  per-host config is needed, ship a wrapper script that sources an env
  file (pattern not yet used in this tap).

## Host-side operation

After any formula change the deploy commands are the same everywhere:

```sh
brew update
brew upgrade m5d215/tap/<name>          # or: brew reinstall
brew services restart <name>            # if it's a service
```

For services:

- Status / paths: `brew services info <name>`
- Log paths: inspect `brew services info` output or tail
  `/opt/homebrew/var/log/<name>.log`.
- There is **no `brew services log`** subcommand. Tail the log file
  directly.
