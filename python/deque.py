from collections import deque

def 마지막_남는_카드(N):
    muQueue = deque()  # 큐 생성

    for i in range(1, N + 1): # 1번부터 N번 큐에 카드 삽입
        muQueue.append(i)

    while len(muQueue) > 1:
        muQueue.popleft()  # 맨 위 카드 버리기
        muQueue.append(muQueue.popleft())  # 다음 카드 아래로 옮기기

    return muQueue[0]  # 남은 카드 번호

if __name__ == "__main__":
    N = int(input("카드의 개수 N을 입력하세요 (1~ 500000): "))
    result = 마지막_남는_카드(N)
    print(result)
