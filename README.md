# dev-lab

학습한 개념을 코드로 검증하는 실험실.

## 구조

```text
dev-lab/
├── algorithms/
│   ├── patterns/         # 풀이 패턴 정리
│   └── daily/            # 일일 문제 풀이
├── experiments/
│   └── {topic-id}/       # 주제별 실험 코드 + README
├── metrics/              # before/after 지표 스냅샷
└── CLAUDE.md
```

## 실험 프로세스

```text
가설 수립 → 코드 작성 → 측정 (before/after) → 결론 기록
```

## 실험 ID 규칙

```text
{CATEGORY}-{NN}-{slug}
```

1. `TX`: 트랜잭션/ACID
2. `ISO`: 격리수준/레이스 컨디션
3. `LOCK`: 락/데드락
4. `MVCC`: 버전 가시성
5. `IDX`: 인덱스
6. `OPT`: 실행계획/옵티마이저
7. `REP`: 복제/장애전환

## 마크다운 작성 규칙

- fenced code block 시작 시 언어 태그를 반드시 명시 (`text`, `bash`, `powershell`, `yaml`, `json` 등)
- 언어를 특정하기 어렵다면 `text` 사용

## 알고리즘

- 일일 풀이: `algorithms/daily/YYYY-MM-DD-{problem-name}.kt`
- 패턴 정리: `algorithms/patterns/{pattern-name}.md`
