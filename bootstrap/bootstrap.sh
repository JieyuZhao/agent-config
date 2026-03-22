mkdir -p .agent-config .claude/commands
curl -sfL https://raw.githubusercontent.com/yzhao062/agent-config/main/AGENTS.md -o .agent-config/AGENTS.md
cp -f .agent-config/AGENTS.md AGENTS.md
if [ -d .agent-config/repo/.git ]; then
  git -C .agent-config/repo pull --ff-only
else
  git clone --depth 1 --filter=blob:none --sparse https://github.com/yzhao062/agent-config.git .agent-config/repo
fi
git -C .agent-config/repo sparse-checkout set skills .claude
if [ -d .agent-config/repo/.claude/commands ]; then
  cp -f .agent-config/repo/.claude/commands/*.md .claude/commands/
fi
if [ -f .agent-config/repo/.claude/settings.json ]; then
  if [ -f .claude/settings.json ]; then
    _py=$(command -v python3 || command -v python)
    if [ -n "$_py" ]; then
      "$_py" -c "
import json, pathlib as P
s=json.loads(P.Path('.agent-config/repo/.claude/settings.json').read_text())
p=json.loads(P.Path('.claude/settings.json').read_text())
p.update(s)
P.Path('.claude/settings.json').write_text(json.dumps(p,indent=2)+'\n')
"
    fi
  else
    cp -f .agent-config/repo/.claude/settings.json .claude/settings.json
  fi
fi
if [ ! -f .gitignore ] || ! grep -qx '\.agent-config/' .gitignore; then
  echo '.agent-config/' >> .gitignore
fi
