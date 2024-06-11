<template>
  <div class="split">
    <q-splitter
      v-model="insideModel"
      horizontal
      :style="height"
      separator-class="bg-grey-6"
      separator-style="height: 3px"
    >
      <template #before>
        <tag-list @update="updateTag"></tag-list>
      </template>

      <template #after>
        <q-scroll-area
          :thumb-style="thumbStyle"
          :bar-style="barStyle"
          style="height: 100%"
          class="bg-info"
        >
          <div class="text-h6 q-ml-md q-mt-sm text-white">
            {{ selectedTag }}
          </div>
          <q-list dense separator>
            <q-item
              clickable
              v-ripple
              v-for="note in notes"
              :key="note.id"
              :active="selectedNote === note.id"
              @click="
                selectedNote = note.id;
                $emit('update', note);
              "
              class="text-white"
              active-class="bg-negative text-black text-weight-bold"
            >
              {{ note.name }}
            </q-item>
          </q-list>
        </q-scroll-area>
      </template>
    </q-splitter>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, onBeforeMount } from "vue";
import TagList from "./TagList.vue";

//Calculate height in pixel
const height = ref("height: " + window.innerHeight + "px");
window.addEventListener("resize", reportWindowSize);
function reportWindowSize() {
  height.value = "height: " + window.innerHeight + "px";
}

//variables
const thumbStyle = {
  right: "4px",
  borderRadius: "5px",
  backgroundColor: "#027be3",
  width: "5px",
  opacity: 0.75,
};

const barStyle = {
  right: "2px",
  borderRadius: "9px",
  backgroundColor: "#027be3",
  width: "9px",
  opacity: 0.2,
};

function updateTag(title) {
  console.log("title " + title);
  selectedTag.value = title;
}

const emit = defineEmits(["update"]);

onMounted(() => {
  console.log(
    "Se ha montado el componente: " + findNoteById(selectedNote.value)
  );
  emit("update", findNoteById(selectedNote.value));
});

const insideModel = ref(40);

const selectedTag = ref("");

const notes = [
  {
    id: "1",
    name: "Nota Ruddy Jedrzej",
  },
  {
    id: "2",
    name: "Nota Mallorie Alessandrini",
  },
  {
    id: "3",
    name: "Nota Elisabetta Wicklen",
  },
  {
    id: "4",
    name: "Nota Sekaa Fawdrey",
  },
  {
    id: "5",
    name: "Nota Ruddyy Jedrzej",
  },
  {
    id: "6",
    name: "Nota Malloriee Alessandrini",
  },
  {
    id: "7",
    name: "Nota Elisabettaa Wicklen",
  },
  {
    id: "8",
    name: "Nota Sekaa Fawdrey",
  },
  {
    id: "9",
    name: "Nota2 Sekaa Fawdrey",
  },
  {
    id: "10",
    name: "Nota2 Ruddyy Jedrzej",
  },
  {
    id: "11",
    name: "Nota2 Malloriee Alessandrini",
  },
  {
    id: "12",
    name: "Nota2 Elisabettaa Wicklen",
  },
  {
    id: "13",
    name: "Nota2 Sekaa Fawdrey",
  },
  {
    id: "14",
    name: "Nota2 Sekaa Fawdrey",
  },
  {
    id: "15",
    name: "Nota2 Ruddyy Jedrzej",
  },
  {
    id: "16",
    name: "Nota2 Malloriee Alessandrini",
  },
  {
    id: "17",
    name: "Nota2 Elisabettaa Wicklen",
  },
  {
    id: "18",
    name: "Nota2 Sekaa Fawdrey",
  },
];

const selectedNote = ref(notes[0].id);

//funciones
function findNoteById(id) {
  return notes.find((note) => {
    return note.id === id;
  });
}
</script>
