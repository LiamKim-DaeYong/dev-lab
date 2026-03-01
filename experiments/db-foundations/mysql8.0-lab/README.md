# dev-lab MySQL 8.0

`realmysql8.0` 실습용 Docker Compose 환경입니다.

## 1) 시작

```powershell
cd E:\Project\dev-console\_repos\dev-lab\experiments\db-foundations\mysql8.0-lab
Copy-Item .env.example .env
docker compose up -d
```

## 2) 접속

- MySQL: `localhost:3306`
- DB: `.env`의 `MYSQL_DATABASE` (기본 `lab_db`)
- User: `.env`의 `MYSQL_USER` (기본 `lab_user`)
- Password: `.env`의 `MYSQL_PASSWORD` (기본 `lab_pass1234`)
- Root Password: `.env`의 `MYSQL_ROOT_PASSWORD`

Adminer(UI): `http://localhost:8080`

## 3) SQL 접속 예시

```powershell
docker exec -it dev-lab-mysql80 mysql -u root -p
```

```sql
USE lab_db;
SELECT * FROM members;
```

## 4) 대용량 샘플 데이터(선택)

`example/employees/employees.sql`은 파일 크기(약 200MB)로 저장소에는 포함하지 않았습니다.
해당 실습이 필요하면 로컬에서 별도로 내려받아 아래 경로에 두고 사용하세요.

- 저장 경로: `experiments/db-foundations/mysql8.0-lab/example/employees/employees.sql`

`example/create_load_database.sql`은 위 파일이 존재한다는 전제로 `SOURCE employees.sql`을 실행합니다.

## 5) 중지/삭제

```powershell
docker compose down
```

데이터까지 삭제:

```powershell
docker compose down -v
```
