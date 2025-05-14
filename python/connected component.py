# 입력 받기
n, m = map(int, input("노드 수와 간선 수를 입력해주세요요 (예: 6 5): ").split())

# 그래프 초기화
graph = {i: [] for i in range(1, n + 1)}
visited = {i: False for i in range(1, n + 1)}

# DFS구현
def dfs(node, graph, visited):
    visited[node] = True
    for neighbor in graph[node]:
        if not visited[neighbor]:
            dfs(neighbor, graph, visited)

# 간선 정보 입력
print(f"{m}개의 간선을 입력하세요 (예: 1 2):")
for _ in range(m):
    u, v = map(int, input().split())
    graph[u].append(v)
    graph[v].append(u)

# 연결 요소 개수 계산
connected_components = 0
for node in range(1, n + 1):
    if not visited[node]:
        dfs(node, graph, visited)
        connected_components += 1

# 결과 출력
print(f"연결 요소의 개수는 {connected_components}개입니다.")