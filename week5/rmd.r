    library(gutenbergr)
    library(dplyr)
    library(stringr)
    pride_id <- gutenberg_metadata %>%
      filter(str_detect(title, "Pride and Prejudice"))
    pride_id

    pride_id_filtered <- gutenberg_works() %>%
      filter(str_detect(title, "Pride and Prejudice"))
    pride_id_filtered

    book <- gutenberg_download(pride_id_filtered$gutenberg_id)

    library(tidytext)
    words <- book %>%
      unnest_tokens(word, text)

    words <- words %>%
      mutate(word_number = row_number())

    data("stop_words")
    words_clean <- words %>%
      anti_join(stop_words, by = "word") %>%
      filter(!str_detect(word, "^\\d+$"))

    afinn <- get_sentiments("afinn")
    words_sentiment <- words_clean %>%
      inner_join(afinn, by = "word")

    library(ggplot2)
    ggplot(words_sentiment, aes(x = word_number, y = value)) +
      geom_line() +
      geom_smooth(method = "loess") +
      labs(x = "Word Number", y = "Sentiment Score", title = "Sentiment Score vs Location")

    words_sentiment <- words_sentiment %>%
      mutate(page = word_number %/% 300)

    page_sentiment <- words_sentiment %>%
      group_by(page) %>%
      summarize(avg_sentiment = mean(value, na.rm = TRUE))

    ggplot(page_sentiment, aes(x = page, y = avg_sentiment)) +
      geom_line() +
      geom_smooth(method = "loess") +
      labs(x = "Page", y = "Average Sentiment", title = "Average Sentiment by Page")

