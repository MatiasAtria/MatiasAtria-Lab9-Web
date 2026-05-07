# VetClinic — Lab 7

## Setup

```bash
bundle install
bin/rails db:setup
bin/rails server
```

## System Dependencies

**libvips** is required for Active Storage image variants (resizing thumbnails).

- macOS: `brew install vips`
- Ubuntu/Debian: `sudo apt install libvips`
- Arch Linux: `sudo pacman -S libvips`

## Trix Sanitization Check

Pasted `<script>alert(1)</script>` into a Treatment's clinical notes via the Trix editor,
saved the record, and confirmed that on the show page no alert fired and the script tag
does not appear in the rendered HTML. Action Text strips it automatically.