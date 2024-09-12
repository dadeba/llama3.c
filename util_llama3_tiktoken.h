#include "encoding.h"
#include "emdedded_resource_reader.h"
#include <fstream>
#include <iostream>

class TFilePathResourceReader : public IResourceReader {
public:
    TFilePathResourceReader(const std::string& path)
        : path_(path)
    {
    }

    std::vector<std::string> readLines() override {
        std::ifstream file(path_);
        if (!file.is_open()) {
            throw std::runtime_error("Embedded resource '" + path_ + "' not found.");
        }

        std::string line;
        std::vector<std::string> lines;
        while (std::getline(file, line)) {
            lines.push_back(line);
        }

        return lines;
    }
private:
    std::string path_;
};

std::shared_ptr<GptEncoding> encoder;

void encode_tiktoken(std::shared_ptr<GptEncoding> encoder, char *text, int8_t bos, int8_t eos, int *tokens, int *n_tokens) {
  // encode the string text (input) into an upper-bound preallocated tokens[] array
  // bos != 0 means prepend the BOS token (=1), eos != 0 means append the EOS token (=2)
  if (text == NULL) {
    fprintf(stderr, "cannot encode NULL text\n");
    exit(EXIT_FAILURE);
  }

  auto tokens_gpt = encoder->encode(text, {}, {});

  // add optional BOS (=128000) token, if desired
  if (bos)
    tokens_gpt.insert(tokens_gpt.begin(), 128000);

  // add optional EOS (=128001) token, if desired
  if (eos)
    tokens_gpt.push_back(128001);

  *n_tokens = tokens_gpt.size();
  memcpy(tokens, tokens_gpt.data(), (*n_tokens)*sizeof(int));
}

void output(std::shared_ptr<GptEncoding> encoder, int token, int next)
{
  std::vector<int> tmp;
  tmp.push_back(next);
  std::cout << encoder->decode(tmp) << std::flush;
}
