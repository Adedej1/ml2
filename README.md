
# 📩 SMS Spam Classifier in R

This project demonstrates how to classify SMS messages as **spam** or **ham** (not spam) using **text mining** and a **Naive Bayes classifier** in R. It's a practical introduction to natural language processing (NLP) and machine learning applied to real-world SMS data.

---

## 🔍 Project Overview

The goal is to detect whether an incoming SMS message is spam based on its content. The process includes:

- Loading and exploring SMS data
- Cleaning and preprocessing text data
- Creating a Document-Term Matrix (DTM)
- Training a Naive Bayes classifier
- Visualizing important features
- Evaluating the model’s performance with a confusion matrix

---

## 📁 Files

- `messages_filtering.R` – The main R script with the full pipeline
- `sms_spam.csv` – Dataset of labeled SMS messages *(add this file to your working directory)*

---

## 🧰 Requirements

Make sure these R packages are installed:

```r
install.packages("tm")
install.packages("wordcloud")
install.packages("quanteda")
install.packages("e1071")
install.packages("gmodels")
```

---

## 🚀 How to Run

1. Clone the repo:
   ```bash
   git clone https://github.com/your-username/sms-spam-classifier.git
   cd sms-spam-classifier
   ```

2. Add `sms_spam.csv` to your R working directory.

3. Open and run `messages_filtering.R` in RStudio.

---

## 🧪 Model Summary

**Text Preprocessing**:
- Converted to lowercase
- Removed punctuation, numbers, stopwords
- Stripped whitespace

**Model**:
- Naive Bayes Classifier (`e1071`)

**Evaluation**:
- Confusion matrix from `gmodels::CrossTable`

---

## 🌐 Visualizations

### 🌀 Word Clouds

The following word clouds highlight the most frequent terms in the spam and ham messages.

#### 📬 Ham Word Cloud
![Ham Word Cloud](images/ham_wordcloud.png)

#### 🚨 Spam Word Cloud
![Spam Word Cloud](images/spam_wordcloud.png)

You can generate these using:

```r
wordcloud(ham$text, max.words = 40, scale = c(3, 0.5), random.order = FALSE)
wordcloud(spam$text, max.words = 40, scale = c(3, 0.5), random.order = FALSE)
```

---

### 🧮 Confusion Matrix

The confusion matrix compares predicted vs actual labels on the test data.

![Confusion Matrix](images/confusion_matrix.png)

You can generate it using:

```r
CrossTable(sms_test_pred, sms_raw_test$type,
           prop.chisq = FALSE, prop.t = FALSE,
           dnn = c('Predicted', 'Actual'))
```

---

## 📚 Dataset

- **Source**: [UCI SMS Spam Collection](https://archive.ics.uci.edu/ml/datasets/sms+spam+collection)

---

## 👤 Author

- Your Name – [your.email@example.com]

---

## 📄 License

This project is licensed under the MIT License.

---

## 💡 Contribution

Pull requests are welcome! Feel free to fork the repo and improve or expand the project.

---

## 📸 Note on Images

Place your image files inside a folder named `/images` at the root of your repository:

```
sms-spam-classifier/
├── images/
│   ├── ham_wordcloud.png
│   ├── spam_wordcloud.png
│   └── confusion_matrix.png
├── messages_filtering.R
├── sms_spam.csv
└── README.md
```

You can export the plots from RStudio using *"Export > Save as Image"* or `png()`/`jpeg()` functions in R.
