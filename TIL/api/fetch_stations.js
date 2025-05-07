const fetch = require("node-fetch");
const fs = require("fs");

const API_KEY = "Ss1oqrxEJeZWB2n737U08XyxvdG6k2Uy5nNEwvX0LpBNyTrtrZEK2iDGCCioQXriqSaZIzoZv1HlnLxbIIO4Hw%3D%3D";
const URL = `http://apis.data.go.kr/B552584/MsrstnInfoInqireSvc/getMsrstnList?serviceKey=${API_KEY}&returnType=json&numOfRows=1000&pageNo=1`;

async function main() {
  try {
    console.log("📡 측정소 목록 요청 중...");
    const res = await fetch(URL);
    const json = await res.json();
    const items = json.response?.body?.items;
    if (!items) throw new Error("API 응답 오류");

    const regionMap = {};

    for (const item of items) {
      const region = extractRegion(item.addr);
      const lat = parseFloat(item.dmY);
      const lng = parseFloat(item.dmX);
      const station = item.stationName;

      if (!region || isNaN(lat) || isNaN(lng)) continue;

      // 같은 지역에 이미 등록된 측정소가 없으면 저장
      if (!regionMap[region]) {
        regionMap[region] = {
          region,
          station,
          lat,
          lng,
        };
      }
    }

    const result = Object.values(regionMap);
    fs.writeFileSync("stations.json", JSON.stringify(result, null, 2), "utf-8");
    console.log("✅ stations.json 생성 완료:", result.length, "개");
  } catch (e) {
    console.error("❌ 오류 발생:", e.message);
  }
}

// 시/군/구 중 하나 추출
function extractRegion(addr) {
  const match = addr.match(/([가-힣]+(?:시|군|구))/);
  return match?.[1] || null;
}

main();
