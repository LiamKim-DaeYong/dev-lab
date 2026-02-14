# dev-lab

개념 적용 실험실. 학습한 내용을 코드로 검증하는 곳.

## 대화 시작 시 필수

1. `ai-context-hub/state/current.yml` 읽기
2. `ai-context-hub/curriculum/backend-developer.yml`에서 현재 주제의 lab 항목 확인
3. `experiments/` 에서 기존 실험 확인

## 디렉토리 구조

- `algorithms/patterns/` — 풀이 패턴별 정리 (Phase 0)
- `algorithms/daily/` — 일일 문제 풀이
- `experiments/{topic-id}/` — 주제별 실험 코드
- `metrics/` — before/after 지표 스냅샷

## 실험 규칙

- 실험 디렉토리: `experiments/{topic-id}/`
- 각 실험에 `README.md` 포함: 가설, 방법, 결과, 결론
- 가능하면 before/after 지표를 `metrics/{topic-id}.yml`에 기록
- 실험 결과는 블로그 글의 근거로 사용

## 알고리즘 풀이 규칙

- 파일명: `algorithms/daily/YYYY-MM-DD-{problem-name}.kt`
- 각 풀이에 시간복잡도, 풀이 접근법 주석 포함
- 패턴 정리: `algorithms/patterns/{pattern-name}.md`
