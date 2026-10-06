# Design Review Dimensions

Checklist for the design-review skill. Evaluate the code against each
dimension. Not every dimension will have findings; do not invent them.

## 1. Architecture and boundaries

- Layer violations (HTTP handlers doing SQL, domain logic in controllers or
  CLI commands, business rules in templates)
- Circular or tangled dependencies between modules
- God modules or classes with too many responsibilities
- Leaky abstractions; abstractions with one implementation and no reason
- Wrong-level coupling to frameworks, ORMs, or vendors

## 2. Redundancy and duplication

- Copy-pasted logic that should be one function
- Parallel implementations of the same concept (two config loaders, two DB
  access paths, two retry helpers)
- Dead code, unused modules, stale feature flags, unreachable branches
- Duplicated sources of truth (constants, schemas, enums defined twice)

## 3. Performance

- N+1 queries, queries in loops, missing batching
- Unbounded result sets, missing pagination or streaming
- Repeated expensive work that should be cached or hoisted
- Wrong data structures (linear scans where a set or dict fits, repeated
  list concatenation, quadratic patterns)
- Blocking I/O in async code; sync calls on hot paths
- Missing or misused indexes implied by query patterns

For each, state the mechanism and the input size where it starts to hurt.
Without a measurement, label it SUSPECTED.

## 4. Correctness and robustness

- Swallowed exceptions, broad except clauses, errors logged and ignored
- Race conditions, non-atomic read-modify-write, missing transactions
- Non-idempotent operations that get retried
- Missing input validation at trust boundaries
- Timezone, encoding, float-money, and off-by-one hazards
- Resource leaks (connections, files, sessions not closed)

## 5. Data and state management

- Schema design problems, missing constraints, nullable-everything
- Migrations that are unsafe to run or roll back
- Hidden global or mutable shared state
- Implicit ordering dependencies between components

## 6. Configuration and security

- Secrets in code or committed config (detect by pattern and file name;
  never print the values)
- Environment handling that can silently point dev or test at production
- Injection risks (SQL, shell, path), unsafe deserialization
- Overly broad permissions or credentials

## 7. Testability and tests

- Code that is hard to test because of hidden dependencies
- Tests that assert implementation instead of behavior, over-mocked tests,
  tests that cannot fail
- Critical paths with no coverage
- Flaky patterns (sleeps, real clocks, order dependence, shared state)

## 8. Maintainability

- Functions doing several unrelated things; deep nesting
- Misleading names (names that lie about behavior, not style nits)
- Magic numbers and strings with business meaning
- Comments that contradict the code
- Dependency hygiene: unpinned, abandoned, or redundant packages

## Severity

- CRITICAL: causes or will cause data loss, security exposure, production
  incidents, or incorrect results.
- HIGH: significant design flaw that will compound; meaningful performance
  problem at current or near-term scale.
- MEDIUM: real debt with a clear cost, but contained.
- LOW: worth fixing when touching the area. The merge step caps these at
  10 and summarizes the rest in one line.
