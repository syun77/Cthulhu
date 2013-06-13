#!/usr/bun/ruby

require 'yaml'

# シナリオパターンの取得
def getScenarioPattern
	# シナリオバターンの設定
	yaml = YAML.load_file 'scenario.txt'

	# タイトル取得
	val = rand(yaml.size)
	p val

	# パターン取得
	parttern = yaml[val]
	# タイトル取得
	title = parttern["title"]
	# 詳細取得
	val = rand(parttern["detail"].size)
	p val
	detail = parttern["detail"][val]

	str = "■２．シナリオの目的：#{title}\n#{detail}\n\n"

	return str
end

# シナリオの発端の取得
def getScenarioCause
	# シナリオバターンの設定
	yaml = YAML.load_file 'cause.txt'

	# タイトル取得
	val = rand(yaml.size)
	p val

	# パターン取得
	parttern = yaml[val]
	# タイトル取得
	title = parttern["title"]
	# 詳細取得
	val = rand(parttern["detail"].size)
	p val
	detail = parttern["detail"][val]

	str = "■１．発端の怪異：#{title}\n#{detail}\n\n"

	return str
end

# シナリオの真相の取得
def getScenarioTruth
	# シナリオバターンの設定
	yaml = YAML.load_file 'truth.txt'

	# タイトル取得
	val = rand(yaml.size)
	p val

	# パターン取得
	parttern = yaml[val]
	# タイトル取得
	title = parttern["title"]
	# 詳細取得
	val = rand(parttern["detail"].size)
	p val
	detail = parttern["detail"][val]

	str = "■３．事件の真相：#{title}\n#{detail}\n\n"

	return str
end

# サブチャート	【場所】/ 【人物】
def getSubChartTitleAndDetail(str, keyword)
	yaml = YAML.load_file keyword + '.txt'

	# タイトル取得
	val = rand(yaml.size)
	p val

	# パターン取得
	parttern = yaml[val]
	# タイトル取得
	title = parttern["title"]
	# 詳細取得
	val = rand(parttern["detail"].size)
	p val
	detail = parttern["detail"][val]

	ret = str
	tmp = "#{title} -> #{detail}\n"
	tmp = getSubChart(tmp)
	ret += keyword + "とは：" + tmp
	return ret
end

# サブチャート【未踏査地域】
def getSubChartTitle(str, keyword)
	yaml = YAML.load_file keyword + '.txt'

	# タイトル取得
	val = rand(yaml.size)
	p val

	# タイトル取得
	title = yaml[val]

	str += keyword + "とは：#{title}\n"

	return str
end

# サブチャートの取得
def getSubChart(str)
	matches = str.scan(/【.+?】/)
	matches.each do |v|
		#str += "find" + v + "\n"
		case v
		when "【場所】"
			p "match place."
			str = getSubChartTitleAndDetail(str, v)
		when "【未踏査地域】"
			p "match invisible."
			str = getSubChartTitle(str, v)
		when "【人物】"
			p "match person"
			str = getSubChartTitleAndDetail(str, v)
		when "【怪物】"
			p "match monster"
			str = getSubChartTitleAndDetail(str, v)
		when "【神格】"
			p "match god"
			str = getSubChartTitleAndDetail(str, v)
		when "【超自然現象】"
			p "match nature"
			str = getSubChartTitleAndDetail(str, v)
		when "【門の彼方】"
			p "match gate"
			str = getSubChartTitleAndDetail(str, v)
		end
	end

	return str
end

# 出力ファイルを開く
f = open("out.txt", "w")

# 発端の怪異
str = getScenarioCause
str = getSubChart(str)
f.write(str)
f.write("----------------\n")

# シナリオパターン
str = getScenarioPattern
str = getSubChart(str)
f.write(str)
f.write("----------------\n")

# 事件の真相
str = getScenarioTruth
str = getSubChart(str)
f.write(str)

f.close