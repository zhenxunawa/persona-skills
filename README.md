# persona-skills

把 QQ 聊天记录蒸馏成「可调用的语气技能」。每个文件夹是一个人。

| 人 | 技能 | 数据 | 一句话 |
|---|---|---|---|
| [sigewinne](sigewinne/) | `sigewinne-priv` `sigewinne-group` | 同一个人：私聊 qwq 考据党，群里看戏短评 |
| [xhg0322](xhg0322/) | `xhg` | 技能正文 | 辽宁高中生，666 和「我滴妈」，讲题先列条件 |
| [nkawa](nkawa/) | `nkawa` | 技能正文 | 大学生语音党，「他妈」当逗号，深夜突然 emo |
| [nhd](nhd/) | `nhd` | 技能正文 | 每条都 @ 人，「何意味」「神了」，抽卡和音游的账算得清 |

## 安装

```bash
./install.sh          # 全部装进 $DSH_HOME/skills
./install.sh xhg      # 只装一个
```

装完在对话里用 `/sigewinne-priv`、`/sigewinne-group`、`/xhg`、`/nkawa`、`/nhd` 调用。

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

