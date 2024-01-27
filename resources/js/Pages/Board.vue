<script setup>
import {Bars2Icon} from "@heroicons/vue/24/solid";
import {Menu, MenuButton, MenuItem, MenuItems} from '@headlessui/vue';
import CreateBoardListForm from '@/Components/Board/CreateBoardListForm.vue';
import CardList from "@/Components/Board/CardList.vue";
import CardItemModal from "@/Components/Board/CardItemModel.vue";
import {Link} from "@inertiajs/vue3";

const props = defineProps({
  lists: Object,
  card: Object
});

const dbDump = () => {
  axios.get('/board/export')
    .then(function (response) {
      console.log(response);
      alert('DB exported, please check the public directory');
    })
    .catch(function (error) {
      console.log(error);
    });
}

</script>
<template>
  <div class="flex flex-col h-screen bg-blue-600">
    <header class="shrink-0 flex justify-between bg-white px-4 py-3">
      <a class="text-2xl font-black tracking-tight" href="/">kanboard</a>
      <nav class="flex items-center">
        <a class="text-sm font-medium px-3 py-2 rounded-md hover:bg-gray-100" href="#">My boards</a>

        <Menu as="div" class="ml-3 relative z-10">
          <MenuButton class="focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-400 rounded-full">
            <img class="h-9 w-9 inline rounded-full" src="https://pbs.twimg.com/profile_images/1333896976602193922/MtWztkxt_400x400.jpg" alt="">
          </MenuButton>

          <transition
            enter-active-class="transition transform duration-100 ease-out"
            enter-from-class="opacity-0 scale-90"
            enter-to-class="opacity-100 scale-100"
            leave-active-class="transition transform duration-100 ease-in"
            leave-from-class="opacity-100 scale-100"
            leave-to-class="opacity-0 scale-90"
          >
            <MenuItems class="origin-top-right mt-2 focus:outline-none absolute right-0 bg-white overflow-hidden rounded-md shadow-lg border w-48">
              <MenuItem v-slot="{active}">
                <a href="#" :class="{'bg-gray-100': active}" class="block px-4 py-2 text-sm text-gray-700">My Profile</a>
              </MenuItem>
              <MenuItem v-slot="{active}">
                <a href="#" :class="{'bg-gray-100': active}" class="block px-4 py-2 text-sm text-gray-700">Log out</a>
              </MenuItem>
            </MenuItems>
          </transition>
        </Menu>
      </nav>
    </header>

    <main class="flex-1 overflow-hidden">
      <div class="flex flex-col h-full">
        <div class="shrink-0 flex justify-between items-center p-4">
          <h1 class="text-2xl text-white font-bold">Laravel Developer Board</h1>
          <div>
            <!-- <Link
              :href="`/board/export`"
              method="get"
              class="inline-flex items-center bg-white/10 hover:bg-white/20 px-3 py-2 font-medium text-sm text-white rounded-md">
              <Bars2Icon class="w-5 h-5"/>
              <span class="ml-1">Export DB</span>
            </Link> -->
            <a
                href="#"
              @click="dbDump"
              class="inline-flex items-center bg-white/10 hover:bg-white/20 px-3 py-2 font-medium text-sm text-white rounded-md">
              <Bars2Icon class="w-5 h-5"/>
              <span class="ml-1">Export DB</span>
            </a>
          </div>
        </div>
        <div class="flex-1 overflow-x-auto">
          <div class="inline-flex h-full items-start px-4 pb-4 space-x-4">
            <CardList v-if="lists.length > 0"
              v-for="list in lists"
              :key="list.id"
              :list="list"
              class="w-72 bg-gray-200 max-h-full flex flex-col rounded-md">
            </CardList>

            <div class="w-72">
                <CreateBoardListForm/>
            </div>
          </div>
        </div>
      </div>
    </main>
  </div>

  <CardItemModal :card="props.card"  />
</template>
