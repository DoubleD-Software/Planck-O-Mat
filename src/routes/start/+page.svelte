<script>
    import { Button } from "$lib/components/ui/button";
    import {
        Card,
        CardHeader,
        CardContent,
        CardFooter,
        CardTitle,
        CardDescription,
    } from "$lib/components/ui/card";
    import { onMount } from "svelte";
    import { goto } from "$app/navigation";
    import {
        ChevronLeft,
        ChevronRight,
        Circle,
        CircleDot,
    } from "lucide-svelte";

    let data = {};
    let currentTitle = "Laden...";
    let currentDescription = "Bitte warten";
    let currentThesis = 0;
    let answers = [];
    let numTheses = 1;

    onMount(async () => {
        try {
            const res = await fetch("data.json");
            data = await res.json();
            answers = [];
            updateCard();
            numTheses = data.theses.length;
        } catch (error) {
            console.error("Failed to fetch data:", error);
            currentTitle = "Fehler beim Laden";
            currentDescription = "Bitte später erneut versuchen.";
        }
    });

    function updateCard() {
        currentTitle = data.theses[currentThesis].topic;
        currentDescription = data.theses[currentThesis].description;
    }

    function agree() {
        answers[currentThesis] = 1;
        nextThesis();
    }

    function neutral() {
        answers[currentThesis] = 0;
        nextThesis();
    }

    function disagree() {
        answers[currentThesis] = -1;
        nextThesis();
    }

    function nextThesis(manualChange = false) {
        if (manualChange) {
            currentThesis++;
            if (currentThesis >= data.theses.length) {
                currentThesis = 0;
            }
            updateCard();
            return;
        }

        let allAnswered = true;
        let oldThesis = currentThesis;

        for (let i = currentThesis; i < data.theses.length; i++) {
            if (answers[i] == undefined) {
                allAnswered = false;
                currentThesis = i;
                break;
            }
        }
        if (oldThesis == currentThesis) {
            for (let i = 0; i < data.theses.length; i++) {
                if (answers[i] == undefined) {
                    allAnswered = false;
                    currentThesis = i;
                    break;
                }
            }
        }

        if (!allAnswered) {
            updateCard();
            return;
        }

        let max_score = data.theses.length;
        let score_per_party = [];
        for (let i = 0; i < data.parties.length; i++) {
            score_per_party.push(0);
            for (let j = 0; j < data.theses.length; j++) {
                if (answers[j] == data.parties[i].positions[j]) {
                    score_per_party[i]++;
                } else if (
                    answers[j] == 0 ||
                    data.parties[i].positions[j] == 0
                ) {
                    score_per_party[i] += 0.5;
                }
            }
            data.parties[i].percentage = (score_per_party[i] / max_score) * 100;
        }
        localStorage.setItem("result", JSON.stringify(data));
        goto("/result");
        return;
    }

    function lastThesis() {
        currentThesis--;
        if (currentThesis < 0) {
            currentThesis = data.theses.length - 1;
        }
        updateCard();
    }
</script>

<svelte:head>
    <title>Abstimmung | Planck-O-Mat</title>
</svelte:head>

<div class="flex justify-center p-4">
    <div class="flex flex-col w-[100%] max-w-[50rem]">
        <p class="text-3xl md:text-4xl font-[Arial] font-bold">
            Plancktopia Wahl 2025
        </p>
        <Card
            class="mt-[2rem] rounded-none border-[2px] dark:border-white border-black"
        >
            <CardHeader>
                <CardTitle class="text-lg"
                    >{currentThesis + 1}/{numTheses} {currentTitle}</CardTitle
                >
            </CardHeader>
            <CardContent>
                <CardDescription class="text-black dark:text-white text-2xl">
                    {currentDescription}
                </CardDescription>
            </CardContent>
            <CardFooter class="flex flex-col md:flex-row">
                <Button
                    onclick={agree}
                    class="w-[100%] mb-4 md:mb-0 md:w-[25%] md:mr-4 rounded-none border-[2px] dark:border-white border-black md:dark:hover:bg-white md:dark:hover:text-black md:hover:text-white md:hover:bg-black duration-500"
                    variant="outline">stimme zu</Button
                >
                <Button
                    onclick={neutral}
                    class="w-[100%] mb-4 md:mb-0 md:w-[25%] md:mr-4 rounded-none border-[2px] dark:border-white border-black md:dark:hover:bg-white md:dark:hover:text-black md:hover:text-white md:hover:bg-black duration-500"
                    variant="outline">neutral</Button
                >
                <Button
                    onclick={disagree}
                    class="w-[100%] md:w-[25%] rounded-none border-[2px] dark:border-white border-black md:dark:hover:bg-white md:dark:hover:text-black md:hover:text-white md:hover:bg-black duration-500"
                    variant="outline">stimme nicht zu</Button
                >
            </CardFooter>
        </Card>
        <div class="flex justify-center mt-6">
            <Button
                variant="outline"
                class="mr-auto rounded-none border-none dark:hover:bg-white dark:hover:text-black hover:text-white hover:bg-black duration-500"
                onclick={lastThesis}
                ><ChevronLeft strokeWidth={5}></ChevronLeft></Button
            >

            <div class="w-[60%] flex mt-2 flex-wrap justify-center">
                {#each Array(numTheses) as _, i}
                    {#if i == currentThesis}
                        <Circle
                            class="mx-[0.1rem] cursor-pointer dark:text-white dark:fill-white fill-black text-black"
                            onclick={() => {
                                currentThesis = i;
                                updateCard();
                            }}
                        />
                    {:else if answers[i] == 1 || answers[i] == 0 || answers[i] == -1}
                        <CircleDot
                            class="mx-[0.1rem] cursor-pointer"
                            onclick={() => {
                                currentThesis = i;
                                updateCard();
                            }}
                        />
                    {:else}
                        <Circle
                            class="mx-[0.1rem] cursor-pointer"
                            onclick={() => {
                                currentThesis = i;
                                updateCard();
                            }}
                        />
                    {/if}
                {/each}
            </div>
            <Button
                class="ml-auto rounded-none border-none dark:hover:bg-white dark:hover:text-black hover:text-white hover:bg-black duration-500"
                variant="ghost"
                onclick={() => nextThesis(true)}
                ><ChevronRight strokeWidth={5}></ChevronRight></Button
            >
        </div>
    </div>
</div>
