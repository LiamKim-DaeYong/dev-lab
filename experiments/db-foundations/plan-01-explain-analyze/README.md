# PLAN-01: EXPLAIN (ANALYZE, BUFFERS)로 계획 읽기

## Goal
`EXPLAIN (ANALYZE, BUFFERS)` 결과에서
`Seq Scan -> Index Scan` 변화와 `rows/loops/buffers`를 숫자로 확인한다.

## What You Will Verify
1. `baseline`:
   - 인덱스 없음 -> `Seq Scan` 중심 계획
2. `candidate`:
   - 복합 인덱스 추가 후 -> `Index Scan` 또는 `Index Only Scan` 중심 계획
3. 실행 시간, rows, loops, buffers 수치를 비교해 원인을 설명한다.

## Run
실행 위치: `E:\Project\dev-console\_repos\dev-lab\experiments\db-foundations\plan-01-explain-analyze`

```powershell
# 1) 준비
cd _repos/dev-lab/experiments/db-foundations/plan-01-explain-analyze
docker compose up -d
docker compose exec -T db psql -U lab -d labdb -v ON_ERROR_STOP=1 -f /scripts/00_schema.sql

# 2) baseline (인덱스 없음)
docker compose exec -T db psql -U lab -d labdb -v ON_ERROR_STOP=1 -f /scripts/10_baseline_seq_scan.sql

# 3) candidate (복합 인덱스 추가)
docker compose exec -T db psql -U lab -d labdb -v ON_ERROR_STOP=1 -f /scripts/20_candidate_index_scan.sql

# 4) 분포 확인(선택)
docker compose exec -T db psql -U lab -d labdb -v ON_ERROR_STOP=1 -f /scripts/30_verify_distribution.sql
```

## Record Template
아래 항목을 `_repos/dev-lab/metrics/db-foundations.yml`의 `plan-01-explain-analyze`에 채운다.

1. baseline:
   - plan_node:
   - execution_time_ms:
   - actual_rows:
   - loops:
   - buffer_hits:
   - buffer_reads:
2. candidate:
   - plan_node:
   - execution_time_ms:
   - actual_rows:
   - loops:
   - buffer_hits:
   - buffer_reads:

## Reading Guide
1. `actual rows`가 예상보다 크게 벗어나면 통계/선택도 오차를 의심한다.
2. `loops`가 큰 노드가 있으면 작은 오차가 누적되어 병목이 커질 수 있다.
3. `Buffers: shared hit/read`로 CPU성 병목(hit 중심)과 I/O성 병목(read 중심)을 구분한다.

## Learner Status
- [ ] baseline 직접 실행
- [ ] candidate 직접 실행
- [ ] 결과를 metrics에 기록
- [ ] 3줄 회고 작성

## Cleanup
```powershell
docker compose down -v
```
