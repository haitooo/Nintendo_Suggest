all: build

build:
	docker compose up --build

re:
	docker compose down -v
	docker compose build --no-cache
	docker compose up

up:
	docker compose up

down:
	docker compose down

fclean:
	docker compose down -v --rmi all

logs:
	docker compose logs -f

ps:
	docker compose ps

## ---- Kubernetes / minikube ----

minikube: _mk_start _mk_addons _mk_build _mk_apply _mk_wait
	@echo ""
	@echo "デプロイ完了！"
	@echo "アクセス先: http://$$(minikube ip):30080"

_mk_start:
	minikube start --cpus=7 --memory=13000

_mk_addons:
	minikube addons enable metrics-server

_mk_build:
	@eval $$(minikube docker-env) && \
		docker build -t nintendo-suggest-backend:latest ./backend && \
		docker build -t nintendo-suggest-frontend:latest ./frontend && \
		docker build -t nintendo-suggest-db:latest ./db

_mk_apply:
	kubectl apply -f k8s/namespace.yaml -f k8s/secret.yaml
	kubectl apply -f k8s/db/ -f k8s/backend/ -f k8s/frontend/

_mk_wait:
	@echo "Pod が起動するまで待機中..."
	kubectl wait --for=condition=Ready pod --all -n nintendo-suggest --timeout=180s

rekube:
	@eval $$(minikube docker-env) && \
		docker build -t nintendo-suggest-backend:latest ./backend && \
		docker build -t nintendo-suggest-frontend:latest ./frontend && \
		docker build -t nintendo-suggest-db:latest ./db
	kubectl apply -f k8s/namespace.yaml -f k8s/secret.yaml
	kubectl apply -f k8s/db/ -f k8s/backend/ -f k8s/frontend/
	kubectl rollout restart deployment/backend -n nintendo-suggest
	kubectl rollout restart deployment/frontend -n nintendo-suggest
	@echo "再デプロイ完了待機中..."
	kubectl rollout status deployment/backend -n nintendo-suggest
	kubectl rollout status deployment/frontend -n nintendo-suggest

watch:
	@echo "=== [Tab1] HPA監視 ==="
	@echo "=== [Tab2] Pod監視 ==="
	@echo "=== [Tab3] リソース使用量 ==="
	@echo ""
	watch -n 2 ' \
		echo "--- HPA ---"; \
		kubectl get hpa -n nintendo-suggest; \
		echo ""; \
		echo "--- Pods ---"; \
		kubectl get pods -n nintendo-suggest; \
		echo ""; \
		echo "--- リソース使用量 ---"; \
		kubectl top pods -n nintendo-suggest 2>/dev/null || echo "(metrics 準備中...)"; \
	'

k6test:
	@echo "負荷テスト開始: http://$$(minikube ip):30080"
	k6 run -e BASE_URL=http://$$(minikube ip):30080 k6/load-test.js

testclean:
	@echo "minikube 環境を削除中..."
	-kubectl delete namespace nintendo-suggest --ignore-not-found
	minikube stop
	minikube delete --all --purge
	@echo "k6 の一時ファイルを削除中..."
	-rm -f /tmp/k6-*.json
	-rm -f k6/results*.json
	@echo "testclean 完了"

.PHONY: all build re up down fclean logs ps \
	minikube _mk_start _mk_addons _mk_build _mk_apply _mk_wait \
	rekube watch k6test testclean
