#include <iostream>
#include <sentencepiece_processor.h>
sentencepiece::SentencePieceProcessor processor;

const char instruct_prompt_1[] = "<s>\n\n### 指示:\n";
const char instruct_prompt_2[] = "\n\n### 応答:\n";

void encode_sp(char *text, int8_t bos, int8_t eos, int *tokens, int *n_tokens) {
  // encode the string text (input) into an upper-bound preallocated tokens[] array
  // bos != 0 means prepend the BOS token (=1), eos != 0 means append the EOS token (=2)
  if (text == NULL) {
    fprintf(stderr, "cannot encode NULL text\n");
    exit(EXIT_FAILURE);
  }

  std::vector<int> tokens_gpt;
  processor.Encode(text, &tokens_gpt);

  // add optional BOS (=1) token, if desired
  if (bos)
    tokens_gpt.insert(tokens_gpt.begin(), 1);

  // add optional EOS (=2) token, if desired
  if (eos)
    tokens_gpt.push_back(2);

  *n_tokens = tokens_gpt.size();
  memcpy(tokens, tokens_gpt.data(), (*n_tokens)*sizeof(int));
}

void output_sp(int token, int next)
{
  std::vector<int> tmp;
  tmp.push_back(next);

  std::string text;
  processor.Decode(tmp, &text);
  std::cout << text << std::flush;
  //  std::cout << text << "(" << next << ")" << std::flush;
}
