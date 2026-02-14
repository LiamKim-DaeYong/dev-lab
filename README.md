# dev-lab

학습한 개념을 코드로 검증하는 실험실.

## 구조

```
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

```
가설 수립 → 코드 작성 → 측정 (before/after) → 결론 기록
```

## 알고리즘

- 일일 풀이: `algorithms/daily/YYYY-MM-DD-{problem-name}.kt`
- 패턴 정리: `algorithms/patterns/{pattern-name}.md`
