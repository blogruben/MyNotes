<template>
  <div class="split">
    <q-splitter
      v-model="insideModel"
      horizontal
      :style="height"
      separator-style="height: 3px"
      class="bg-info"
      before-class="column"
      after-class="column"
    >
      <template #before>
        <tag-list @update="updateTag"></tag-list>
      </template>

      <template #after>
        <div class="row">
          <div class="text-h6 q-pl-md q-pt-xs text-white">
            {{ selectedTag.label }}

            <q-popup-edit v-model="selectedTag.label" auto-save v-slot="scope">
              <q-input
                class="q-ml-md"
                v-model="scope.value"
                dense
                autofocus
                @keyup.enter="scope.set"
              />
            </q-popup-edit>
          </div>

          <q-btn flat round color="white" size="0.7em" icon="sell">
            <q-tooltip class="">Create new Note</q-tooltip>
          </q-btn>
        </div>

        <q-separator
          class="q-ml-md"
          color="grey-7"
          style="height: 1px; opacity: 0.2"
          v-show="showSeparator"
        />

        <div class="col" id="listNotes">
          <q-scroll-area
            :visible="true"
            :thumb-style="thumbStyle"
            style="height: 100%"
            ref="scrollPosition"
            @scroll="onScroll"
          >
            <q-list dense separator>
              <q-item
                clickable
                v-ripple
                v-for="note in notes"
                :key="note.id"
                :active="selectedNote.idActiveNote === note.id"
                @click="
                  selectedNote.idActiveNote = note.id;
                  $emit('update', note);
                "
                class="text-white"
                active-class="bg-negative text-black text-weight-bold rounded-borders"
              >
                {{ note.name }}
              </q-item>
            </q-list>
          </q-scroll-area>
        </div>
      </template>
    </q-splitter>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from "vue";
import TagList from "./TagList.vue";

const showSeparator = computed(() => {
  return selectedNote.value.verticalPx < 15;
});

//Calculate height in pixel
const height = ref("height: " + window.innerHeight + "px");

let activatedNotes = ref([
  { idTag: "1", idActiveNote: "16", verticalPx: 188 },
  { idTag: "1-1", idActiveNote: "1", verticalPx: 0 },
  { idTag: "1-2", idActiveNote: "1", verticalPx: 0 },
  { idTag: "2", idActiveNote: "2", verticalPx: 0 },
  { idTag: "3", idActiveNote: "3", verticalPx: 0 },
  { idTag: "3-1", idActiveNote: "1", verticalPx: 0 },
  { idTag: "3-2", idActiveNote: "1", verticalPx: 0 },
  { idTag: "3-2-1", idActiveNote: "1", verticalPx: 0 },
  { idTag: "3-2-2", idActiveNote: "1", verticalPx: 0 },
  { idTag: "4", idActiveNote: "1", verticalPx: 0 },
  { idTag: "5", idActiveNote: "1", verticalPx: 0 },
  { idTag: "6", idActiveNote: "1", verticalPx: 0 },
  { idTag: "7", idActiveNote: "1", verticalPx: 0 },
  { idTag: "8", idActiveNote: "1", verticalPx: 0 },
  { idTag: "9", idActiveNote: "1", verticalPx: 0 },
  { idTag: "10", idActiveNote: "1", verticalPx: 0 },
]);
window.addEventListener("resize", reportWindowSize);
function reportWindowSize() {
  height.value = "height: " + window.innerHeight + "px";
}

//variables
const thumbStyle = {
  right: "4px",
  borderRadius: "5px",
  backgroundColor: "#704214",
  width: "5px",
  opacity: 0.7,
};

function onScroll({ verticalPosition }) {
  selectedNote.value.verticalPx = verticalPosition;
}

function updateTag(tag) {
  let currentNote = getCurrentActivatedNotes();
  currentNote = selectedNote.value;
  const activatedNote = getActivatedNoteNewTag(tag);

  //update tag title
  selectedTag.value = tag;
  //update active note
  selectedNote.value = activatedNote;
  scrollPosition.value.setScrollPosition("vertical", activatedNote.verticalPx);
  //console.table(activatedNotes.value);
}

function getCurrentActivatedNotes() {
  const index = activatedNotes.value.findIndex(
    (obj) => obj.idTag == selectedTag.value.id
  );
  return activatedNotes.value[index];
}

function getActivatedNoteNewTag(tag) {
  const note = activatedNotes.value.find((obj) => {
    return obj.idTag === tag.id;
  });
  return note;
}

const emit = defineEmits(["update"]);

onMounted(() => {
  emit("update", findNoteById(selectedNote.value.idActiveNote));
});

const insideModel = ref(40);

const selectedTag = ref({ id: "1", label: "" });
const selectedNote = ref({ idTag: "1", idActiveNote: "1", verticalPx: "0" });
const scrollPosition = ref(null);
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

//funciones
function findNoteById(id) {
  return notes.find((note) => {
    return note.id === id;
  });
}
</script>
