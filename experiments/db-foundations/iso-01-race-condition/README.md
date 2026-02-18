# ISO-01: Race Condition and Isolation Guard

## Goal
격리/잠금 없이 "읽은 값을 믿고 쓰는" 패턴이 왜 위험한지 재현하고,
원자적 업데이트 조건으로 어떻게 방어하는지 확인한다.

## What You Will Verify
1. `baseline` (naive interleaving):
   - 서로 같은 재고 스냅샷을 읽고 주문을 둘 다 넣어 oversell 발생
2. `candidate` (atomic guard):
   - `UPDATE ... WHERE stock > 0` + `RETURNING` 방식으로 oversell 방지

## Run
실행 위치: `E:\Project\dev-console\_repos\dev-lab\experiments\db-foundations\iso-01-race-condition`

```powershell
# 1) DB 기동
docker compose up -d

# 2) 스키마 초기화
docker compose exec -T db psql -U lab -d labdb -v ON_ERROR_STOP=1 -f /scripts/00_schema.sql

# 3) baseline 실행
docker compose exec -T db psql -U lab -d labdb -v ON_ERROR_STOP=1 -f /scripts/10_naive_interleaving.sql
docker compose exec -T db psql -U lab -d labdb -f /scripts/30_verify.sql

# 4) 초기화
docker compose exec -T db psql -U lab -d labdb -f /scripts/99_reset.sql

# 5) candidate 실행
docker compose exec -T db psql -U lab -d labdb -v ON_ERROR_STOP=1 -f /scripts/20_atomic_guard.sql
docker compose exec -T db psql -U lab -d labdb -f /scripts/30_verify.sql
```

## Expected Outcome
1. baseline:
   - `orders_count = 2`
   - `inventory_stock = 0`
   - `status = OVERSOLD` (초기 재고 1인데 판매량 2)
2. candidate:
   - `orders_count = 1`
   - `inventory_stock = 0`
   - `status = OK`

## Learner Status
- [ ] baseline 실행
- [ ] candidate 실행
- [ ] 결과 3줄 요약

## Cleanup
```powershell
docker compose down -v
```
