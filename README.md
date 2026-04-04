# personal-website

A personal portfolio site that fetches and showcases all public GitHub repositories for [@nickmayn](https://github.com/nickmayn).

## Features

- **Live project cards** — pulls repos from the GitHub API (with a static cache fallback) and renders them in a responsive grid
- **Search & filter** — filter by language, sort by last-updated / stars / name / newest
- **GitHub Pages hosting** — automatically deployed on every push to `main`
- **Daily refresh** — a scheduled GitHub Action snapshots the latest repo data and re-deploys the site each morning at 06:00 UTC

## Setup

### 1. Enable GitHub Pages

1. Go to **Settings → Pages** in this repository.
2. Under *Source*, choose **GitHub Actions**.
3. Save the settings.

### 2. Push to `main`

The [deploy workflow](.github/workflows/deploy.yml) runs automatically on every push to `main` and publishes the site to `https://<your-username>.github.io/personal-website/`.

### 3. Daily auto-refresh

The [update workflow](.github/workflows/update.yml) runs on a daily cron (`0 6 * * *` UTC). It snapshots your public repos into `data/repos.json` and re-deploys the site so the "last active" timestamps stay current.

You can also trigger either workflow manually from the **Actions** tab.

## Local preview

Open `index.html` directly in a browser — it will fetch your repos live from the GitHub API.
