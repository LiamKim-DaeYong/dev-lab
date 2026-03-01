# PLAN-03: Index Scan vs Index Only Scan (Heap Fetches / Visibility Map)

## Goal
같은 쿼리를 기준으로 아래를 검증한다.

1. non-covering 인덱스에서 `Index Scan`이 선택되는지
2. covering 인덱스에서 `Index Only Scan`이 선택되는지
3. `VACUUM` 전후로 `Heap Fetches`가 어떻게 바뀌는지

## What You Will Verify
1. baseline:
   - `Index Scan`
   - `Heap Fetches` 없음(표시 자체가 없거나 의미 없음)
2. candidate-before-vacuum:
   - `Index Only Scan`
   - `Heap Fetches`가 상대적으로 큼
3. candidate-after-vacuum:
   - `Index Only Scan`
   - `Heap Fetches` 감소(이상적으로 0 또는 매우 낮음)

## Run
실행 위치: `E:\Project\dev-console\_repos\dev-lab\experiments\db-foundations\plan-03-index-only-scan-visibility`

```powershell
# 1) prepare
cd _repos/dev-lab/experiments/db-foundations/plan-03-index-only-scan-visibility
docker compose up -d
docker compose exec -T db psql -U lab -d labdb -v ON_ERROR_STOP=1 -f /scripts/00_schema.sql

# 2) baseline (non-covering index)
docker compose exec -T db psql -U lab -d labdb -v ON_ERROR_STOP=1 -f /scripts/10_baseline_index_scan.sql

# 3) candidate-before-vacuum (covering index + visibility map 불리한 상태)
docker compose exec -T db psql -U lab -d labdb -v ON_ERROR_STOP=1 -f /scripts/20_candidate_index_only_pre_vacuum.sql

# 4) candidate-after-vacuum
docker compose exec -T db psql -U lab -d labdb -v ON_ERROR_STOP=1 -f /scripts/30_candidate_index_only_post_vacuum.sql
```

## Record Template
아래 항목을 `_repos/dev-lab/metrics/db-foundations.yml`에 추가한다.

1. plan-03-index-only-scan-visibility
   - baseline:
     - plan_node:
     - execution_time_ms:
     - actual_rows:
     - loops:
     - buffer_hits:
     - buffer_reads:
   - candidate_before_vacuum:
     - plan_node:
     - execution_time_ms:
     - heap_fetches:
     - actual_rows:
     - loops:
     - buffer_hits:
     - buffer_reads:
   - candidate_after_vacuum:
     - plan_node:
     - execution_time_ms:
     - heap_fetches:
     - actual_rows:
     - loops:
     - buffer_hits:
     - buffer_reads:

## Learner Status
- [ ] baseline 실행
- [ ] candidate-before-vacuum 실행
- [ ] candidate-after-vacuum 실행
- [ ] `Heap Fetches` 변화 해석

## Cleanup
```powershell
docker compose down -v
```
