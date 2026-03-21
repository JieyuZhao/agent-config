mkdir -p .agent-config .claude/commands
curl -sfL https://raw.githubusercontent.com/yzhao062/agent-config/main/AGENTS.md -o .agent-config/AGENTS.md
cp -f .agent-config/AGENTS.md AGENTS.md
if [ -d .agent-config/repo/.git ]; then
  git -C .agent-config/repo pull --ff-only
else
  git clone --depth 1 --filter=blob:none --sparse https://github.com/yzhao062/agent-config.git .agent-config/repo
fi
git -C .agent-config/repo sparse-checkout set skills .claude/commands
if [ -d .agent-config/repo/.claude/commands ]; then
  cp -f .agent-config/repo/.claude/commands/*.md .claude/commands/
fi
if [ ! -f .gitignore ] || ! grep -qx '\.agent-config/' .gitignore; then
  echo '.agent-config/' >> .gitignore
fi
