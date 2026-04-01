const { PrismaClient } = require('@prisma/client');

const prisma = new PrismaClient();

// 需要添加的新订阅源
const newFeeds = [
  {
    id: 'MP_WXS_' + Math.floor(Math.random() * 9000000000 + 1000000000),
    mpName: '志明论债',
    mpCover: '',
    mpIntro: '志明论债',
    syncTime: 0,
    updateTime: Math.floor(Date.now() / 1000),
    status: 1,
  },
  {
    id: 'MP_WXS_' + Math.floor(Math.random() * 9000000000 + 1000000000),
    mpName: 'CSC研究金融团队',
    mpCover: '',
    mpIntro: 'CSC研究金融团队',
    syncTime: 0,
    updateTime: Math.floor(Date.now() / 1000),
    status: 1,
  },
];

async function main() {
  console.log('开始添加新订阅源...');

  for (const feed of newFeeds) {
    try {
      const existing = await prisma.feed.findFirst({
        where: { mpName: feed.mpName },
      });

      if (existing) {
        console.log(`跳过已存在的: ${feed.mpName}`);
        continue;
      }

      const created = await prisma.feed.create({
        data: feed,
      });
      console.log(`添加成功: ${created.mpName} (${created.id})`);
    } catch (err) {
      console.error(`添加失败: ${feed.mpName}`, err.message);
    }
  }

  // 验证结果
  const allFeeds = await prisma.feed.findMany({
    orderBy: { createdAt: 'asc' },
  });
  console.log(`\n当前共有 ${allFeeds.length} 个订阅源:`);
  allFeeds.forEach((f, i) => {
    console.log(`  ${i + 1}. ${f.mpName}`);
  });
}

main()
  .catch(console.error)
  .finally(() => prisma.$disconnect());
