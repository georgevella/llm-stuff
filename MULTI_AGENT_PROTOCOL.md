# MULTI_AGENT_PROTOCOL.md

Purpose: keep planner/executor/reviewer communication crisp, auditable, and hard to misunderstand.

## 0) Core Rules

1. One role per turn: `planner` OR `executor` OR `reviewer`.
2. No role blending (planner does not implement; executor does not redefine scope).
3. Every task has a `Task ID`.
4. No completion claims without verification evidence.
5. Stop and escalate on ambiguity, destructive changes, auth/secrets, or conflicting signals.
6. Any workspace file change requires a git commit; if pre-existing uncommitted changes exist, checkpoint-commit first.
7. For YAGR-related changes, all agents must use commit subjects with a `(<scope>)` of `yagr` (e.g., `feat(yagr): ...`, `fix(yagr): ...`).

---

## 1) Standard Request Envelope (from user to planner)

Use this exact shape:

```text
Mode=<plan|execute|review|debug>
Goal=<what success looks like>
Constraints=<time/risk/tech/no-go>
Deliverable=<exact output format>
Depth=<quick|normal|deep>
```

Example:

```text
Mode=plan
Goal=Expose internal OpenClaw UI via reverse proxy
Constraints=internal-only, no downtime, no direct internet exposure
Deliverable=numbered plan + rollback + validation commands
Depth=normal
```

---

## 2) Planner Output Contract

Planner must always produce:

1. **Task Graph** (numbered subtasks, dependencies)
2. **Assignment Map** (`executor-a`, `executor-b`, ...)
3. **Acceptance Criteria** per subtask
4. **Validation Commands** per subtask
5. **Risk + Rollback** per subtask
6. **Merge Plan** (how outputs are reconciled)

Planner output template:

```text
Task ID: <ID>
Objective: <one sentence>

Subtasks:
1) <subtask> (owner: executor-a)
   - Inputs:
   - Acceptance criteria:
   - Validation commands:
   - Risk/rollback:

2) <subtask> (owner: executor-b)
   ...

Merge/Reconcile:
- Conflict checks:
- Final validation:
```

---

## 3) Executor Handoff Packet (planner -> executor)

Use this exact packet:

```text
Task ID: <ID>
Subtask ID: <ID-N>
Scope: <what to do>
Inputs: <files/env/context>
Assumptions: <explicit assumptions>
Constraints: <hard limits>
Done Criteria: <testable conditions>
Validation Commands: <exact commands>
Artifacts Expected: <files/paths/outputs>
Escalation Trigger: <when to stop and ask>
```

---

## 4) Executor Completion Report (executor -> planner)

Required format:

```text
Task ID: <ID>
Subtask ID: <ID-N>
Status: <green|yellow|red>

Changes Made:
- <file/config/command>

Commands Run:
- <command>

Key Output:
- <short evidence>

Validation Results:
- <pass/fail + output>

Artifacts:
- <paths>

Risks/Notes:
- <issues or caveats>

Rollback:
- <exact undo steps>
```

No report in this format = subtask not complete.

---

## 5) Reviewer Checklist

Reviewer must verify:

1. Scope match (no hidden/extra changes)
2. Acceptance criteria met
3. Validation output is real and sufficient
4. Rollback works and is documented
5. Security impact checked (auth, exposure, secrets)
6. Cross-subtask conflicts checked

Reviewer output:

```text
Task ID: <ID>
Review Status: <approved|changes-required|blocked>
Findings:
- <severity:low|med|high> <issue>
Required Fixes:
- <action>
```

---

## 6) Escalation Policy (mandatory stop conditions)

Any agent must stop and escalate if:

- requirement ambiguity blocks safe execution
- destructive action is required
- auth/tokens/secrets are involved unexpectedly
- production impact risk is unclear
- two data sources conflict
- validation fails unexpectedly

Escalation format:

```text
ESCALATION
Task ID: <ID>
Reason: <why blocked>
Decision Needed: <specific yes/no or options>
Options:
1) <safe option>
2) <faster/riskier option>
Recommended: <option #>
```

---

## 7) Communication Cadence

For long tasks, use compact updates:

```text
Task ID: <ID>
Status: <green|yellow|red>
Done:
- ...
Blocked:
- ...
Next:
- ...
ETA: <UTC time>
```

Default cadence: update every major milestone, not every tiny step.

---

## 8) Decision Log (single source of truth)

Maintain `ops/DECISIONS.md` with:

```text
## <UTC timestamp> — <Decision title>
Task ID: <ID>
Decision:
Reason:
Impact:
Rollback Trigger:
Owner:
```

No major architectural/security change should be considered final without a decision log entry.

---

## 9) Definitions of Done

### Planner DoD
- Task graph complete
- Owners assigned
- Criteria + validation defined
- Merge/reconcile plan present

### Executor DoD
- Scope implemented
- Validation commands executed
- Evidence captured
- Rollback documented

### Reviewer DoD
- Evidence checked
- Risks assessed
- Conflicts resolved
- explicit approve/changes-required decision issued

---

## 10) Suggested Agent Personalities (brief)

- **Planner**: analytical, decomposition-first, conservative on risk.
- **Executor**: precise, action-oriented, minimal prose, evidence-heavy.
- **Reviewer**: skeptical, verification-first, security-aware.

---

## 11) Fast-Start Commands (for human use)

Use these prompts to drive consistency:

```text
Mode=plan
Goal=<...>
Constraints=<...>
Deliverable=Task graph + owner map + acceptance criteria + validation + rollback
Depth=normal
```

```text
Mode=execute
Task ID=<...>
Subtask ID=<...>
Deliverable=Executor Completion Report format
Depth=normal
```

```text
Mode=review
Task ID=<...>
Deliverable=Reviewer Checklist result with approve/changes-required
Depth=deep
```

---

## 12) Anti-Patterns (ban these)

- “Done” with no command output
- Scope changes without explicit approval
- Planner editing production directly
- Executors changing auth/security policy silently
- Reviewer approving without validating evidence

---

This protocol is intentionally strict. Strictness buys speed later by reducing rework and ambiguity.
