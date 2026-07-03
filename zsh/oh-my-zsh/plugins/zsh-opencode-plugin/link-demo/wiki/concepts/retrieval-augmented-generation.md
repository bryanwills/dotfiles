---
type: concept
title: "Retrieval-augmented generation"
aliases: ["RAG", "retrieval augmented generation"]
date_created: "2026-05-02"
date_updated: "2026-05-02"
source_count: 1
tags: [ai, retrieval, context]
maturity: seed
---

# Retrieval-augmented generation

> **TLDR:** Retrieval-augmented generation brings external context into model workflows before generation.

## Overview

Retrieval-augmented generation pairs a model with a retrieval layer. Instead of relying only on model weights or the current chat, a system fetches relevant external context first. *Source: [[transformer-reading-notes]]* `[confidence: high]`

In Link, the retrieval layer is a local markdown wiki exposed through search, context, backlinks, and graph tools. This makes [[agent-memory]] inspectable instead of hidden in a proprietary store. *Source: [[transformer-reading-notes]]* `[confidence: high]`

## Key Facts

- **External retrieval complements LLM context** when information is fresh, private, or project-specific. *Source: [[transformer-reading-notes]]* `[confidence: high]`
- **Persistent memory can be modeled as retrieval** over durable local pages. *Source: [[transformer-reading-notes]]* `[confidence: high]`

## Related

- [[agent-memory]] - a local memory use case for retrieval.
- [[transformers]] - the model architecture that often consumes retrieved context.
- [[link]] - provides the local retrieval surface.

## Sources

- [[transformer-reading-notes]]
