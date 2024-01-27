<script setup>
import { Bars2Icon, PencilIcon, PlusIcon } from "@heroicons/vue/24/solid";
import { Menu, MenuButton, MenuItem, MenuItems } from '@headlessui/vue';
import CreateCardForm from "@/Components/Board/CreateCardForm.vue";
import { ref, watch } from "vue";
import {router, Link} from "@inertiajs/vue3";
import Draggable from 'vuedraggable';

const props = defineProps({
    list: Object
});

const listRef = ref();
const cards = ref(props.list.cards);

function onCardCreated() {
    listRef.value.scrollTop = listRef.value.scrollHeight;
}

function onChange(e) {
  let item = e.added || e.moved;

  if (!item) return;

  let index = item.newIndex;
  let prevCard = cards.value[index - 1];
  let nextCard = cards.value[index + 1];
  let card = cards.value[index];

  let position = card.position;

  if (prevCard && nextCard) {
    position = (prevCard.position + nextCard.position) / 2;
  } else if (prevCard) {
    position = prevCard.position + (prevCard.position / 2);
  } else if (nextCard) {
    position = nextCard.position / 2;
  }

  router.put(route('board.card.move', {card: card.id}), {
    position: position,
    boardListId: props.list.id
  });

}

watch(() => props.list.cards, (newCards) => cards.value = newCards);


</script>
<template>
    <div>
        <div class="flex items-center justify-between px-3 py-2">
            <h3 class="text-sm font-semibold text-gray-700">{{ list.title }}</h3>
            <Menu as="div" class="relative z-10">
                <MenuButton class="hover:bg-gray-300 w-8 h-8 rounded-md grid place-content-center">
                    <Bars2Icon class="w-5 h-5" />
                </MenuButton>

                <transition enter-active-class="transition transform duration-100 ease-out"
                    enter-from-class="opacity-0 scale-90" enter-to-class="opacity-100 scale-100"
                    leave-active-class="transition transform duration-100 ease-in" leave-from-class="opacity-100 scale-100"
                    leave-to-class="opacity-0 scale-90">
                    <MenuItems
                        class="origin-top-left mt-2 focus:outline-none absolute left-0 bg-white overflow-hidden rounded-md shadow-lg border w-40">
                        <MenuItem v-slot="{ active }">
                        <Link
                            :href="`/board/list/${list?.id}`"
                            method="delete"
                            :class="{ 'bg-gray-100': active }"
                            class="block px-4 py-2 text-sm text-red-600"
                            >
                            Delete list
                        </Link>
                        </MenuItem>
                    </MenuItems>
                </transition>
            </Menu>
        </div>
        <div class="pb-3 flex flex-col overflow-hidden">
            <div ref="listRef" class="px-3 flex-1 overflow-y-auto">
                    <Draggable
                        v-model="cards"
                        class="space-y-3"
                        drag-class="drag"
                        ghost-class="ghost"
                        group="cards"
                        item-key="id"
                        tag="ul"
                        @change="onChange"
                    >
                        <template #item="{element}">
                            <ul class="space-y-3">
                                <li :key="element.id">
                                    <div
                                        class="group relative bg-white p-3 shadow rounded-md border-b border-gray-300 hover:bg-gray-50">
                                        <Link :href="route('board', {card: element.id})" class="text-sm" preserve-state>{{ element.title }}</Link>
                                        <Link
                                            :href="route('board', {card: element.id})"
                                            class="hidden absolute top-1 right-1 w-8 h-8 bg-gray-50 group-hover:grid place-content-center rounded-md text-gray-600 hover:text-black hover:bg-gray-200">
                                            <PencilIcon class="w-5 h-5" />
                                        </Link>
                                    </div>
                                </li>
                            </ul>
                        </template>
                    </Draggable>
            </div>
            <div class="px-3 mt-3">
                <CreateCardForm :list="list" @created="onCardCreated()" />
            </div>
        </div>
    </div>
</template>

<style>
.drag > li {
  transform: rotate(5deg);
}

.ghost {
  background: lightgray;
  border-radius: 6px;
}

.ghost > li {
  visibility: hidden;
}
</style>
