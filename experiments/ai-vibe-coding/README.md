# Experiment: AI Vibe Coding and LLM Foundations

## Date
2026-02-18

## Problem

AI usage is ad-hoc and not measured, so real productivity gain is unknown.

## Hypothesis

A structured AI workflow (planner -> builder -> verifier) reduces cycle time by at least 30 percent without increasing defects.

## Scenario

1. Baseline task:
   - implement one small backend feature without AI support.
2. Candidate task:
   - implement same-class feature with AI support and explicit verification.
3. Keep task scope similar:
   - same complexity, same language, same test depth.

## Verification Commands
~~~powershell
# 1) Track baseline coding cycle (manual)
# 2) Track AI-assisted coding cycle (same task class)
# 3) Compare defect/rework count after review
powershell -ExecutionPolicy Bypass -File scripts/today.ps1
~~~

## Result
- baseline:
  - cycle_minutes:
  - error_count:
  - rework_count:
- candidate:
  - cycle_minutes:
  - error_count:
  - rework_count:

## Decision
- keep / iterate / revert

## Residual Risk

Task complexity mismatch can bias results; run at least three iterations.

