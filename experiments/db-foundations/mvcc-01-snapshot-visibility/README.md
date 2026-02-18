# MVCC-01: Snapshot Visibility by Isolation Level

## Goal
같은 "한 트랜잭션 내 두 번의 조회"에서
`READ COMMITTED`와 `REPEATABLE READ`가 왜 다르게 보이는지 체감한다.

## What You Will Verify
1. `READ COMMITTED`:
   - 같은 트랜잭션에서 두 번째 조회가 업데이트된 값을 볼 수 있음
2. `REPEATABLE READ`:
   - 같은 트랜잭션에서 두 번째 조회도 첫 조회와 같은 값을 유지

## Run
실행 위치: `E:\Project\dev-console\_repos\dev-lab\experiments\db-foundations\mvcc-01-snapshot-visibility`

```powershell
# 공통 준비
cd _repos/dev-lab/experiments/db-foundations/mvcc-01-snapshot-visibility
docker compose up -d
docker compose exec -T db psql -U lab -d labdb -v ON_ERROR_STOP=1 -f /scripts/00_schema.sql
```

## Case A: READ COMMITTED
터미널 A:
```powershell
docker compose exec -T db psql -U lab -d labdb -v ON_ERROR_STOP=1 -f /scripts/10_reader_read_committed.sql
```

터미널 B:
```powershell
docker compose exec -T db psql -U lab -d labdb -v ON_ERROR_STOP=1 -f /scripts/11_writer_update.sql
```

기대:
1. reader 1차 조회 값 = 10
2. writer 커밋 후 reader 2차 조회 값 = 11

## Case B: REPEATABLE READ
초기화:
```powershell
docker compose exec -T db psql -U lab -d labdb -f /scripts/99_reset.sql
```

터미널 A:
```powershell
docker compose exec -T db psql -U lab -d labdb -v ON_ERROR_STOP=1 -f /scripts/20_reader_repeatable_read.sql
```

터미널 B:
```powershell
docker compose exec -T db psql -U lab -d labdb -v ON_ERROR_STOP=1 -f /scripts/21_writer_update.sql
```

기대:
1. reader 1차 조회 값 = 10
2. writer 커밋 후에도 reader 2차 조회 값 = 10 (snapshot 고정)
3. 트랜잭션 종료 후 새 조회는 11

## Learner Status
- [x] case A 실행
- [x] case B 실행
- [x] 결과 3줄 요약

요약:
1. `READ COMMITTED`: 같은 트랜잭션 내 재조회에서 `10 -> 11`로 변경됨
2. `REPEATABLE READ`: 같은 트랜잭션 내 재조회가 `10 -> 10`으로 유지됨
3. writer는 11로 커밋되었고, RR reader는 트랜잭션 종료 전까지 snapshot(10)을 본다

## Cleanup
```powershell
docker compose down -v
```
