import pandas as pd
import nltk
import string
from nltk.corpus import stopwords
from nltk.stem import WordNetLemmatizer
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.model_selection import train_test_split
from sklearn.naive_bayes import MultinomialNB
from sklearn.metrics import accuracy_score, classification_report, confusion_matrix

# Λήψη αναγκαίων πόρων του NLTK
nltk.download('stopwords')
nltk.download('wordnet')

# Φόρτωση δεδομένων
df = pd.read_csv("spam.csv", encoding="latin-1")

# Προετοιμασία δεδομένων
df = df[['v1', 'v2']]
df.columns = ['label', 'message']  # Μετονομασία στηλών για ευκολία
df['label'] = df['label'].map({'ham': 0, 'spam': 1})
df.dropna(inplace=True)

# Συνάρτηση καθαρισμού
def preprocess_text(text):
    lemmatizer = WordNetLemmatizer()
    text = text.lower()  # Πεζά
    text = ''.join([char for char in text if char not in string.punctuation])  # Αφαίρεση σημείων στίξης
    text = ''.join([char for char in text if not char.isdigit()])  # Αφαίρεση αριθμών
    words = text.split()
    words = [word for word in words if word not in stopwords.words('english')]  # Αφαίρεση stopwords
    words = [lemmatizer.lemmatize(word) for word in words]  # Lemmatization
    return ' '.join(words)

# Εφαρμογή καθαρισμού
df['cleaned_message'] = df['message'].apply(preprocess_text)

# Επισκόπηση καθαρισμένων δεδομένων
print(df[['message', 'cleaned_message']].head())

# Μετατροπή κειμένου σε διανύσματα TF-IDF
tfidf_vectorizer = TfidfVectorizer()
X = tfidf_vectorizer.fit_transform(df['cleaned_message'])
y = df['label']

# Διαχωρισμός σε training και test set
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Εκπαίδευση μοντέλου Naive Bayes
nb_model = MultinomialNB()
nb_model.fit(X_train, y_train)

# Πρόβλεψη στο test set
y_pred = nb_model.predict(X_test)

# Αξιολόγηση
print("Accuracy:", accuracy_score(y_test, y_pred))
print("\nClassification Report:\n", classification_report(y_test, y_pred))
print("\nConfusion Matrix:\n", confusion_matrix(y_test, y_pred))
