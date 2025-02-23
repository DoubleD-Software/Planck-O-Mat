<script>
    import { onMount } from "svelte";
    import Button from "$lib/components/ui/button/button.svelte";

    let data = { parties: [{ name: "", description: "" }] };

    onMount(async () => {
        try {
            const res = await fetch("data.json");
            data = await res.json();
        } catch (error) {
            console.error("Failed to fetch data:", error);
        }
    });
</script>

<svelte:head>
    <title>Parteien | Planck-O-Mat</title> 
</svelte:head>

<div class="flex justify-center p-4">
    <div class="flex flex-col w-[100%] max-w-[50rem]">
        <p class="text-4xl md:text-5xl font-[Arial] font-bold">Parteien</p>
        <p class="text-2xl md:text-3xl font-[Arial] font-light">
            Plancktopia Wahl 2025
        </p>
        {#each data.parties as party, i}
            <div class="flex border-none rounded-lg pb-4 pt-4">
                <p class="text-2xl font-semibold">{party.name}</p>
                {#if party.program_link}
                    <a
                        href={party.program_link}
                        class="hover:underline ml-auto text-xl text-nowrap"
                        >→ Wahlprogramm</a
                    >
                {/if}
            </div>
            <div class="flex pb-4  items-start">
                <p class="text-lg w-[70%] md:w-[85%] pr-4">
                    {party.description}
                </p>
                {#if party.logo_link}
                    <img
                        src={party.logo_link}
                        alt={party.name}
                        class="ml-auto w-[30%] md:w-[15%] ml-auto mt-0 dark:hidden"
                    />
                {/if}
                {#if party.logo_link_dark}
                    <img
                        src={party.logo_link_dark}
                        alt={party.name}
                        class="ml-auto w-[30%] md:w-[15%] hidden dark:block"
                    />
                {:else }
                    <img
                        src={party.logo_link}
                        alt={party.name}
                        class="ml-auto w-[30%] md:w-[15%] ml-auto mt-0 hidden dark:block"
                    />
                {/if}
            </div>
            {#if i < data.parties.length - 1}
                <hr class="border-1 border-black dark:border-white" />
            {/if}
        {/each}
    </div>
</div>
