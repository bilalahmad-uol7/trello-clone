<script setup>
import { PlusIcon } from '@heroicons/vue/24/solid';
import { nextTick, ref } from "vue";
import { useForm } from "@inertiajs/vue3";

const props = defineProps({
    list: Object
});

const emit = defineEmits(['created']);

const inputTitleRef = ref();
const inputDescriptionRef = ref();
const isShowingForm = ref(false);
const form = useForm({
    title: '',
    description: '',
    board_list_id: props.list.id,
});

async function showForm() {
    isShowingForm.value = true;
    await nextTick();
    inputTitleRef.value.focus();
}

function onSubmit() {
    form.post(route('board.card.store'), {
        onSuccess: () => {
            form.reset();
            inputTitleRef.value.focus();
            emit('created');
        }
    });
}
</script>
<template>
    <form @keydown.esc="isShowingForm = false" v-if="isShowingForm" @submit.prevent="onSubmit()">

        <input v-model="form.title" ref="inputTitleRef"
            class="block w-full text-sm rounded-md border-gray-300 shadow-sm focus:border-blue-400 focus:ring-blue-400"
            placeholder="Enter list title..." type="text" :required=true>
        <textarea ref="inputDescriptionRef" v-model="form.description" rows="3" @keydown.enter.prevent="onSubmit()"
            class="block w-full text-sm mt-1 rounded-md border-gray-300 shadow-sm focus:border-blue-400 focus:ring-blue-400"
            placeholder="Enter card description..."></textarea>

        <div class="mt-2 space-x-2">
            <button
                class="px-4 py-2 text-sm font-medium text-white bg-rose-600 hover:bg-rose-500 rounded-md shadow-sm focus:ring-2 focus:ring-offset-2 focus:ring-rose-500 focus:outline-none"
                type="submit">Add card
            </button>
            <button
                class="px-4 py-2 text-sm font-medium text-gray-700 hover:text-black rounded-md focus:ring-2 focus:ring-offset-2 focus:ring-rose-500 focus:outline-none"
                type="button" @click="isShowingForm = false">Cancel
            </button>
        </div>
    </form>

    <button @click="showForm()" v-if="!isShowingForm"
        class="flex items-center p-2 text-sm font-medium text-gray-600 hover:text-black hover:bg-gray-300 w-full rounded-md">
        <PlusIcon class="h-5 w-5"></PlusIcon>
        <span class="ml-1">Add card</span>
    </button>
</template>
