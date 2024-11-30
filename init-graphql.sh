# Remove old CSS file (if it exists)
rm -f styles.8f1d28c5983cf8f0.css

gunzip -k styles.8f1d28c5983cf8f0.css.gz

echo "body { background: gray; padding: 20px; }" >> styles.8f1d28c5983cf8f0.css

gzip styles.8f1d28c5983cf8f0.css

rm styles.8f1d28c5983cf8f0.css
