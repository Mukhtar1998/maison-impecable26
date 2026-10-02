@echo off
REM Git push script for maison-impeccable
cd "C:\Users\mukht\Desktop\micro-entreprise\mon boite"

echo.
echo === Git Status ===
git status

echo.
echo === Adding all changes ===
git add .

echo.
echo === Committing changes ===
git commit -m "Update: smooth scrolling, email validation for reviews, testimonials toggle, and git tree cleanup"

echo.
echo === Checking remote ===
git remote -v

echo.
echo === Pushing to main ===
git push origin main

echo.
echo === Push complete ===
git log --oneline -5
