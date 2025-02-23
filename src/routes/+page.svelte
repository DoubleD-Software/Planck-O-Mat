<script>
    import { Button } from "$lib/components/ui/button/index.js";
    import { onMount } from "svelte";

    let num_parties = "";

    onMount(async () => {
        try {
            const res = await fetch("data.json");
            let data = await res.json();
            num_parties = data.parties.length;
        } catch (error) {
            console.error("Failed to fetch data:", error);
        }
    });
</script>

<svelte:head>
    <title>Planck-O-Mat</title> 
</svelte:head>

<div class="flex justify-center p-4">
    <div class="flex flex-col justify-start w-[100%] max-w-[50rem]">
        <p class="text-3xl md:text-4xl font-[Arial] font-bold">
            Plancktopia Wahl 2025
        </p>
        <Button
            href="start"
            class="p-[1.75rem] text-[32px] m-auto md:ml-auto md:mr-0 mt-[1rem] rounded-none border-[3px] text-[#4f46e5] hover:text-[#4f46e5] dark:border-white border-black dark:hover:bg-white hover:bg-black duration-500"
            variant="outline">Start</Button
        >
        <p class="text-lg md:text-2xl mt-[1rem] md:mt-[2rem] font-light">
            Alle {num_parties} Parteien, die zur Wahl antreten, haben die Planck-O-Mat-Thesen
            beantwortet. Jetzt bist du an der Reihe: Vergleiche deine Standpunkte
            mit den Antworten der Parteien.
            <br />Der Planck-O-Mat ist keine Wahlempfehlung, sondern ein
            Informationsangebot über Wahlen und Politik. Alle Angaben wurden von
            den Parteien selbst gemacht und unverändert übernommen.
        </p>
    </div>
</div>
