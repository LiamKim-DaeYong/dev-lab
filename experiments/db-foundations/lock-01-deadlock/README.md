# LOCK-01: Deadlock Reproduction and Mitigation

## Goal
락 순서가 다를 때 데드락이 발생함을 재현하고, 락 순서를 통일하면 데드락이 사라지는지 확인한다.

## What You Will Verify
1. `baseline`:
   - Tx A/B가 서로 다른 순서로 행 잠금 -> deadlock detected
2. `candidate`:
   - Tx A/B가 같은 순서로 잠금 -> deadlock 미발생

## Run
실행 위치: `E:\Project\dev-console\_repos\dev-lab\experiments\db-foundations\lock-01-deadlock`

```powershell
# 공통 준비
cd _repos/dev-lab/experiments/db-foundations/lock-01-deadlock
docker compose up -d
docker compose exec -T db psql -U lab -d labdb -v ON_ERROR_STOP=1 -f /scripts/00_schema.sql
```

## Baseline (두 터미널 필요)
터미널 A:
```powershell
docker compose exec -T db psql -U lab -d labdb -v ON_ERROR_STOP=1 -f /scripts/10_tx_a_deadlock.sql
```

터미널 B:
```powershell
docker compose exec -T db psql -U lab -d labdb -v ON_ERROR_STOP=1 -f /scripts/11_tx_b_deadlock.sql
```

기대:
1. 둘 중 하나에서 `deadlock detected` 발생
2. 다른 하나는 커밋 성공

검증:
```powershell
docker compose exec -T db psql -U lab -d labdb -f /scripts/30_verify.sql
```

## Candidate (락 순서 통일)
초기화:
```powershell
docker compose exec -T db psql -U lab -d labdb -f /scripts/99_reset.sql
```

터미널 A:
```powershell
docker compose exec -T db psql -U lab -d labdb -v ON_ERROR_STOP=1 -f /scripts/20_tx_a_ordered.sql
```

터미널 B:
```powershell
docker compose exec -T db psql -U lab -d labdb -v ON_ERROR_STOP=1 -f /scripts/21_tx_b_ordered.sql
```

기대:
1. deadlock 없음
2. 둘 다 커밋 성공(한쪽이 잠시 대기할 수 있음)

## Learner Status
- [x] baseline 실행
- [x] candidate 실행
- [x] 결과 3줄 요약

## Learner Result (2026-02-18)
1. baseline:
   - `deadlock detected` 확인
2. candidate:
   - verify 결과 `account_id=1 -> 70`, `account_id=2 -> 130`
   - 결론: 락 순서 통일 시 deadlock 없이 처리됨

## Cleanup
```powershell
docker compose down -v
```
