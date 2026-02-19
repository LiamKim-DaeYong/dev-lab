# DB Foundations Experiments

## Purpose
이 디렉토리는 DB 기초/심화 학습 내용을 재현 가능한 실습으로 검증한다.

## Labs
1. `tx-01-transaction-boundary` (TX-01)
   - 주제: 트랜잭션 경계 vs 부분 성공(partial success)
   - 상태: learner-done
2. `iso-01-race-condition` (ISO-01)
   - 주제: stale read 기반 oversell 재현과 atomic guard 방어
   - 상태: learner-done (reported)
3. `lock-01-deadlock` (LOCK-01)
   - 주제: deadlock 재현과 락 순서 통일 완화
   - 상태: learner-done
4. `mvcc-01-snapshot-visibility` (MVCC-01)
   - 주제: READ COMMITTED vs REPEATABLE READ 가시성 비교
   - 상태: learner-done
5. `plan-01-explain-analyze` (PLAN-01)
   - 주제: EXPLAIN (ANALYZE, BUFFERS)로 Seq Scan vs Index Scan 비교
   - 상태: pending

