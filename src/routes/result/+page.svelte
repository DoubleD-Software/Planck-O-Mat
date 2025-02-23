<script>
    import { onMount } from "svelte";
    import { Progress } from "$lib/components/ui/progress/index.js";

    let result = {};
    onMount(() => {
        result = JSON.parse(localStorage.getItem("result") || "null");
        if (result == null) {
            location.href = "/";
        }

        result.parties.sort((a, b) => b.percentage - a.percentage);
    });
</script>

<svelte:head>
    <title>Ergebnis | Planck-O-Mat</title> 
</svelte:head>

<div class="flex justify-center p-4">
    <div class="flex flex-col w-[100%] max-w-[50rem]">
        <p class="text-4xl md:text-5xl font-[Arial] font-bold">Dein Ergebnis</p>
        <p class="text-2xl md:text-3xl font-[Arial] font-light">
            Plancktopia Wahl 2025
        </p>
        {#each result.parties as party, i}
            <div class="flex border-none rounded-lg pb-4 pt-4">
                <p class="text-2xl font-semibold">
                    {i + 1}.
                    <a href="/parties" class="hover:underline">
                        {party.name}</a
                    >
                </p>
                <p class="text-2xl text-2xl font-semibold ml-auto">
                    {party.percentage.toFixed(0)}%
                </p>
            </div>
            <Progress value={party.percentage} class="mb-4 md:w-[66%]" />
            <div class="flex pb-4 items-start">
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
                {:else}
                    <img
                        src={party.logo_link}
                        alt={party.name}
                        class="ml-auto w-[30%] md:w-[15%] ml-auto mt-0 hidden dark:block"
                    />
                {/if}
            </div>
            {#if i < result.parties.length - 1}
                <hr class="border-1 border-black dark:border-white" />
            {/if}
        {/each}
    </div>
</div>
