cd Datacard

for src in datacard_MX*_MY*/; do
    base="$(basename "$src")"
    dest="datacards/$base"

    echo "Syncing $src → $dest"
    rsync -a --delete "$src" "$dest"
done
