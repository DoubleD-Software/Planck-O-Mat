<script>
    import { onMount } from "svelte";
    import {
        Accordion,
        AccordionItem,
        AccordionTrigger,
        AccordionContent,
    } from "$lib/components/ui/accordion";
    import { CircleCheck, CircleEqual, CircleX } from "lucide-svelte";

    let data = {
        parties: [{ name: "", positions: [], explanations: [] }],
        theses: [{ description: "" }],
    };

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
    <title>Thesen | Planck-O-Mat</title> 
</svelte:head>

<div class="flex justify-center p-4">
    <div class="flex flex-col w-[100%] max-w-[50rem]">
        <p class="text-4xl md:text-5xl font-[Arial] font-bold">Thesen</p>
        <p class="text-2xl md:text-3xl font-[Arial] font-light">
            Plancktopia Wahl 2025
        </p>
        {#each data.theses as these, i}
            <div class="flex border-none rounded-lg pt-4">
                <p class="text-xl md:text-2xl font-bold">
                    {i + 1}. {these.description}
                </p>
            </div>

            <div class="flex border-none rounded-lg">
                <Accordion class="w-full" type="single">
                    {#each data.parties as party, j}
                        <AccordionItem>
                            <AccordionTrigger>
                                <p
                                    class="flex text-lg md:text-xl font-medium items-center"
                                >
                                    {#if party.positions[i] == 1}
                                        <CircleCheck class="mr-2" />
                                    {:else if party.positions[i] == 0}
                                        <CircleEqual class="mr-2" />
                                    {:else}
                                        <CircleX class="mr-2" />
                                    {/if}
                                    {party.name}
                                </p>
                            </AccordionTrigger>
                            <AccordionContent>
                                <p class="text-base md:text-lg">
                                    {party.explanations[i]}
                                </p>
                            </AccordionContent>
                        </AccordionItem>
                    {/each}
                </Accordion>
            </div>
            {#if i < data.theses.length - 1}
                <hr class="border-1 border-black dark:border-white mt-4" />
            {/if}
        {/each}
    </div>
</div>
