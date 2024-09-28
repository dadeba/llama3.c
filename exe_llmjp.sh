#!/bin/bash
tokenizerpath="./llm-jp-tokenizer/models/ver3.0/llm-jp-tokenizer-100k.ver3.0b1.model" 
model="./llm-jp-3-1.8b_q8.bin"

echo $model
echo $tokenizerpath

text="明日の天気を予測するにはどうすれば良いか、箇条書きで5点まとめてください"
text="LLMの発展について概要をまとめてください"

prompt=$(cat <<EOF
### 指示:
$text

### 応答:
EOF
)

./runq $model -i "$prompt" -n 300 -t 0.75 -z $tokenizerpath
