<script lang="ts">
    import "../app.css";
    import { ModeWatcher, toggleMode } from "mode-watcher";
    import { Button } from "$lib/components/ui/button";
    import { AlignJustify } from "lucide-svelte";
    import {
        DropdownMenu,
        DropdownMenuContent,
        DropdownMenuItem,
        DropdownMenuTrigger,
        DropdownMenuGroup,
        DropdownMenuGroupHeading,
        DropdownMenuSeparator,
    } from "$lib/components/ui/dropdown-menu";
    let { children } = $props();
</script>

<ModeWatcher defaultMode="dark" />

<div class="flex justify-left md:justify-center">
    <p class="text-6xl md:text-9xl font-[Arial] font-bold m-4 max-w-[80%]">
        Planck-O-Mat
    </p>
</div>

<DropdownMenu>
    <DropdownMenuTrigger class="absolute top-5 right-5"
        ><AlignJustify size="36" /></DropdownMenuTrigger
    >
    <DropdownMenuContent class="mr-4" portalProps={{}}>
        <DropdownMenuGroup>
            <DropdownMenuGroupHeading class="" inset=""
                ><p class="text-lg">Navigation</p></DropdownMenuGroupHeading
            >
            <DropdownMenuSeparator class="" inset="" />
            <DropdownMenuItem class="" inset=""
                ><a class="w-[100%] text-lg" href="/">Startseite</a
                ></DropdownMenuItem
            >
            <DropdownMenuItem class="" inset=""
                ><a class="w-[100%] text-lg" href="/result">Ergebnis</a
                ></DropdownMenuItem
            >
            <DropdownMenuItem class="" inset=""
                ><a class="w-[100%] text-lg" href="/parties">Parteien</a
                ></DropdownMenuItem
            >
            <DropdownMenuItem class="" inset=""
                ><a class="w-[100%] text-lg" href="/theses">Thesen</a></DropdownMenuItem
            >
            <DropdownMenuItem class="text-lg cursor-pointer hidden dark:block" inset="" onclick={toggleMode}
            >Light Mode</DropdownMenuItem>
            <DropdownMenuItem class="text-lg cursor-pointer dark:hidden" inset="" onclick={toggleMode}
            >Dark Mode</DropdownMenuItem>
        </DropdownMenuGroup>
    </DropdownMenuContent>
</DropdownMenu>
{@render children()}
