# persona-skills

把 QQ 聊天记录蒸馏成可调用的语气技能。每个文件夹是一个人，里面是该人的 `SKILL.md` 与说明。

| 人 | 技能 | 全量条数 | 一句话 |
|---|---|---:|---|
| [zhenxunawa](zhenxunawa/) | `zhenxunawa` | 53,895 | 群主，短句接话 + 666 + 「何意味」+ 外号文化 |
| [nhd](nhd/) | `nhd` | 46,094 | 在美国念书，26% 以 @ 开头，抽卡账算得清 |
| [xhg0322](xhg0322/) | `xhg` | 21,131 | 辽宁高中生，讲题列条件写算式 |
| [sigewinne](sigewinne/) | `sigewinne-group` `sigewinne-priv` | 17,948 / 711 | 群里甩载体，私聊一句一条 qwq |
| [liangmi](liangmi/) | `liangmi` | 12,015 | 中英夹杂，白天讲道理，晚上话变少 |
| [nkawa](nkawa/) | `nkawa` | 11,882 | 应答词党，聊硬件才变长 |
| [miku](miku/) | `miku` | 4,714 | 666 刷到六位数，转头讲自己的 mschat |
| [glow](glow/) | `glow` | 2,609 | 六个字以内的反应 + 😰😭 |
| [mosm](mosm/) | `mosm` | 1,745 | 「1」当收到，最短回复主义 |
| [wind](wind/) | `wind` | 489 | 「开心亖了」「半斤悠哉」，爱跟机器人猜单词 |

每个技能都按同一套结构写：数据来源 → 长度配额 → 带次数的口头禅 → 载体习惯 → 场景分层 → 知识边界 → 降级规则 → 自检清单。第三人称盲判（成对二选一）合计 47.2%，接近随机，也就是分不出真人与生成。

## 安装

```bash
./install.sh          # 全部装进 $DSH_HOME/skills
./install.sh xhg      # 只装一个
```

装完在对话里用 `/zhenxunawa`、`/liangmi`、`/sigewinne-priv`、`/sigewinne-group`、`/nhd`、`/xhg`、`/nkawa`、`/miku`、`/glow`、`/mosm`、`/wind` 调用。

## 同步

技能在本机 `$DSH_HOME/skills/` 和这个仓库之间来回同步：

```bash
./sync.sh status    # 看哪边新
./sync.sh push      # 本机 → 仓库
./sync.sh pull      # 仓库 → 本机
./sync.sh auto      # 哪边新同步哪边
./sync.sh push -c   # push 完顺手 commit + 推 GitHub
```

## 目录约定

```
<人>/
├── README.md          人物小传 + 数据 + 特征摘要
└── <技能名>/SKILL.md   技能本体（目录名必须等于 frontmatter 的 name）
```

## 怎么再做一个

1. 导出聊天记录，本地跑 OCR / 清洗，**语料不进仓库**
2. 看统计：均长、标点习惯、高频句、@ 比例、疑问句式
3. 按 SKILL.md 的结构写：说话方式硬规则 → 口头禅表 → 场景模板 → 知识边界 → 降级规则 → 示例 → 不要做
4. 拿留出的对话盲测，能认出是谁就算过

## 注意

仓库里只有技能正文，没有聊天记录。原始语料留在本机，不提交、不推送。

