# Planck-O-Mat

The open-source, self-hostable tool that helps citizens match their views to political parties in any simulated election or state.

**NOTE**: The current language is entirely German and we haven't bothered with adding i18n yet. If you do find yourself translating it we would be greatful for a Pull Request!

## Screenshots

Main Page
![img](https://assets.double-d.software/api/public/dl/-0kQlbsy/Planck-O-Mat/start.png)

Answer Mode
![img](https://assets.double-d.software/api/public/dl/_O-CyifR/Planck-O-Mat/answermode.png)

Result
![img](https://assets.double-d.software/api/public/dl/7FG66G29/Planck-O-Mat/result.png)

All Parties
![img](https://assets.double-d.software/api/public/dl/z_ZsWBa5/Planck-O-Mat/parties.png)

All Thesis Answers
![img](https://assets.double-d.software/api/public/dl/-1DZJcAk/Planck-O-Mat/thesis.png)

Light Mode
![img](https://assets.double-d.software/api/public/dl/K-GiCGqR/Planck-O-Mat/light.png)

## Deploying

### Building site source

#### PNPM

To build the Planck-O-Mat with PNPM simply run `pnpm run build` and you should find the built files in `build`.

#### Docker

If you don't have PNPM installed on a host, you may use the provided Docker file. Make sure to have Docker installed and then simply run the provided `build_with_docker.sh` file. You might have to provide it with executing permission with `chmod +x build_with_docker.sh`.

Docker will build the image, build the site, copy the built files into the `dist` directory and finally delete the image leaving no trace.

### Next steps

Now copy the files either from the `build` or the `dist` directory into your web root. If your host is configured correctly to serve the web root, you should now see an unconfigured Planck-O-Mat instance.

## Configuring

All configuration is done through the `data.json` file which you have to create in the web root as well. There is a `data.json.example`, let's look at that.

```json
{
    "parties": [
        {
            "name": "Partei 1",
            "description": "Wir stehen für Chancengleichheit und Freiheit.",
            "positions": [1],
            "explanations": [
                "Umweltschutz ist essentiell, um unsere Heimat, die Erde, zu schützen. Mülltrennung und Recycling sind daher extrem wichtig. Durch Subventionen sichern wir das Unternehmen diese auch umsetzen."
            ],
            "program_link": "/program/Partei1 Wahlprogramm.pdf",
            "logo_link": "/logo/Partei1 Logo.png",
            "logo_link_dark": "/logo/Partei1 Logo Black.png"
        }
    ],
    "theses": [
        {   
            "topic": "Mülltrennung",
            "description": "Der Staat soll sich für Mülltrennung bzw. Müllvermeidung einsetzten und ggf. auch attraktiver machen."
        }
    ]
}
```

The `parties` array contains all parties within the system. Each party has the following properties:

- `name`
- `description`
- `positions`: An array of the party's positions. `1` means approval, `-1` means opposition and `0` means neutral. The first element in the array corresponds with the first thesis, the second element with the second thesis and so on. The order matters!
- `explanations`: All the explanations for each decision. Again, the first explanation is for the first thesis.
- `program_link`: The link to the election program. As it will simply open that link, PDFs are recommended.
- `logo_link`: The party logo to show in light mode.
- `logo_link_dark`: The party logo to show in dark mode. They may be the same file.

The `theses` array contains all theses each party answered. Each contains:

- `topic`: A general thesis heading.
- `description`: The detailed description.

**AGAIN**: Order matters! The first thesis corresponds with the first answer and first explanation of each party.

### Troubleshooting

Make sure that your JSON file is formatted properly! Otherwise it will fail to load. Also try to access the file directly via `https://example.com/data.json` and check if it is accessible.

## Done

You should now have a running Planck-O-Mat instance populated with all parties. Have fun and don't forget to star this repository!