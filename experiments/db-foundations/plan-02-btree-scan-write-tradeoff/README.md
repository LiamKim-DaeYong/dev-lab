# PLAN-02: B-Tree 선택도와 쓰기 비용 트레이드오프

## Goal
하나의 실습에서 아래 두 가지를 함께 검증한다.

1. 선택도에 따라 `Index Scan`과 `Seq Scan`이 어떻게 갈리는가
2. 인덱스 개수가 늘어날수록 `INSERT` 비용이 얼마나 증가하는가

## What You Will Verify
1. `selective query`:
   - 복합 인덱스 전후 실행계획/실행시간 비교
2. `low-selectivity query`:
   - 인덱스가 있어도 `Seq Scan`이 선택되는 상황 확인
3. `write cost`:
   - 무인덱스 테이블 vs 다중 인덱스 테이블의 INSERT 시간 비교

## Run
실행 위치: `E:\Project\dev-console\_repos\dev-lab\experiments\db-foundations\plan-02-btree-scan-write-tradeoff`

```powershell
# 1) 준비
cd _repos/dev-lab/experiments/db-foundations/plan-02-btree-scan-write-tradeoff
docker compose up -d
docker compose exec -T db psql -U lab -d labdb -v ON_ERROR_STOP=1 -f /scripts/00_schema.sql

# 2) selective query baseline (인덱스 없음)
docker compose exec -T db psql -U lab -d labdb -v ON_ERROR_STOP=1 -f /scripts/10_selective_baseline.sql

# 3) selective query candidate (복합 인덱스 추가)
docker compose exec -T db psql -U lab -d labdb -v ON_ERROR_STOP=1 -f /scripts/20_selective_candidate.sql

# 4) low-selectivity query (인덱스 있어도 Seq Scan 관찰)
docker compose exec -T db psql -U lab -d labdb -v ON_ERROR_STOP=1 -f /scripts/30_low_selectivity_seq_scan.sql

# 5) write cost setup
docker compose exec -T db psql -U lab -d labdb -v ON_ERROR_STOP=1 -f /scripts/40_write_cost_setup.sql

# 6) write no-index
docker compose exec -T db psql -U lab -d labdb -v ON_ERROR_STOP=1 -f /scripts/50_write_cost_no_index.sql

# 7) write with-index
docker compose exec -T db psql -U lab -d labdb -v ON_ERROR_STOP=1 -f /scripts/60_write_cost_with_index.sql
```

## Record Template
아래 항목을 `_repos/dev-lab/metrics/db-foundations.yml`의 `plan-02-btree-scan-write-tradeoff`에 채운다.

1. selective_baseline:
   - plan_node:
   - execution_time_ms:
   - actual_rows:
   - loops:
   - buffer_hits:
   - buffer_reads:
2. selective_candidate:
   - plan_node:
   - execution_time_ms:
   - actual_rows:
   - loops:
   - buffer_hits:
   - buffer_reads:
3. low_selectivity:
   - plan_node:
   - execution_time_ms:
   - actual_rows:
   - loops:
4. write_cost:
   - no_index_insert_ms:
   - with_index_insert_ms:
   - write_slowdown_factor:

## Learner Status
- [ ] selective baseline/candidate 직접 실행
- [ ] low-selectivity에서 Seq Scan 확인
- [ ] write cost 비교 실행
- [ ] metrics 기록 + 3줄 회고

## Cleanup
```powershell
docker compose down -v
```
