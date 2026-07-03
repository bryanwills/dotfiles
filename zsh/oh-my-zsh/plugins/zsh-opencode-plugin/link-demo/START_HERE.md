# Link Demo: Start Here

This demo is already ingested. It shows the full loop: source notes, wiki pages,
agent memory, backlinks, graph context, and a compact query packet.

## Try These Agent Prompts

```text
is Link ready?
query Link for why Link helps agents
brief me from Link before we continue
what does Link remember about local personal memory?
explain why Link remembers local personal memory
```

## Try These CLI Checks

```bash
python3 link.py query "why does Link help agents?" . --budget small
python3 link.py brief "working on agent memory" .
python3 link.py memory-audit .
python3 link.py health .
```

## What To Look For

- The query packet includes both memory and source-backed wiki context.
- The packet is budget-limited, so agents do not need to read the whole wiki.
- The memory entry is inspectable under `wiki/memories/`.
- The graph view shows how sources, concepts, memories, and explorations connect.

Open the local viewer:

```bash
python3 link.py serve .
```

Then visit `http://127.0.0.1:3000`, `http://127.0.0.1:3000/brief`, and
`http://127.0.0.1:3000/graph`.
