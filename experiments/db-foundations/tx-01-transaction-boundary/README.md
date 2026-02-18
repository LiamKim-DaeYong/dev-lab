# TX-01: Transaction Boundary vs Partial Success

## Goal
트랜잭션을 잘못 나누면 "주문은 저장됐는데 재고는 안 줄어드는" 부분 성공이 발생함을 재현한다.

## What You Will Verify
1. `baseline`: 주문 저장과 재고 차감을 분리하면 정합성 불일치가 생긴다.
2. `candidate`: 하나의 트랜잭션으로 묶으면 실패 시 전부 롤백된다.

## Prerequisites
1. Docker Desktop 실행 중
2. `docker compose` 명령 가능

## Run
실행 위치: `E:\Project\dev-console\_repos\dev-lab\experiments\db-foundations\tx-01-transaction-boundary`

```powershell
# 1) DB 컨테이너 기동
docker compose up -d

# 2) 스키마/샘플 데이터 준비
docker compose exec -T db psql -U lab -d labdb -v ON_ERROR_STOP=1 -f /scripts/00_schema.sql

# 3) baseline: 트랜잭션 분리(부분 성공 유도)
docker compose exec -T db psql -U lab -d labdb -v ON_ERROR_STOP=0 -f /scripts/10_baseline_split_tx.sql
docker compose exec -T db psql -U lab -d labdb -f /scripts/30_verify_state.sql

# 4) 초기화
docker compose exec -T db psql -U lab -d labdb -f /scripts/99_reset.sql

# 5) candidate: 단일 트랜잭션(전체 롤백)
docker compose exec -T db psql -U lab -d labdb -v ON_ERROR_STOP=0 -f /scripts/20_candidate_single_tx.sql
docker compose exec -T db psql -U lab -d labdb -f /scripts/30_verify_state.sql
```

## Expected Outcome
1. baseline 후:
   - `orders_count` 증가
   - `inventory_stock`는 그대로(또는 변경 실패)
   - 해석: 부분 성공 발생
2. candidate 후:
   - `orders_count` 증가 없음
   - `inventory_stock` 변화 없음
   - 해석: 하나의 트랜잭션으로 실패가 전체 롤백

## Mentor Demo Result (2026-02-18)
1. baseline:
   - `orders_count = 1`
   - `inventory_stock = 1`
   - 판정: 부분 성공 재현됨
2. candidate:
   - `orders_count = 0`
   - `inventory_stock = 1`
   - 판정: 전체 롤백 확인됨

## Note
`CHECK constraint` 에러 출력은 의도된 실패 시나리오다.

## Learner Status
- [x] baseline 직접 실행
- [x] candidate 직접 실행
- [x] 결과 3줄 요약

## Cleanup
```powershell
docker compose down -v
```
