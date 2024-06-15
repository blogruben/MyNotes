<template>
  <div class="split">
    <q-splitter
      v-model="insideModel"
      horizontal
      :style="height"
      separator-class="bg-grey-6"
      separator-style="height: 3px"
      class="bg-info"
      before-class="overflow-hidden-y"
      after-class="overflow-hidden-y"
    >
      <template #before>
        <tag-list @update="updateTag"></tag-list>
      </template>

      <template #after>
        <div class="text-h6 q-pl-md q-pt-sm text-white">
          {{ selectedTag.label }}
        </div>

        <q-scroll-area
          :visible="true"
          :thumb-style="thumbStyle"
          style="height: 100%"
        >
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
let activatedNotes = ref();
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
  opacity: 0.8,
};

function updateTag(tag) {
  activatedNotes.value = getActivatedNotes();
  saveCurrentActivatedNotes();
  console.table("XXX " + JSON.stringify(activatedNotes.value));
  const activatedNote = getActivatedNoteNewTag(tag);

  console.log("selectedTag " + JSON.stringify(tag));
  console.log("selectedNote " + JSON.stringify(activatedNote));

  //update tag title
  selectedTag.value = tag;
  //update active note
  selectedNote.value = activatedNote;
}

function getActivatedNotes() {
  //getActivatedNotes
  let activatedNotes = null; // = sessionStorage.getItem("activatedNotes");
  if (!activatedNotes) {
    activatedNotes = [
      { idTag: "1", idActiveNote: "16" },
      { idTag: "1-1", idActiveNote: "1" },
      { idTag: "1-2", idActiveNote: "1" },
      { idTag: "2", idActiveNote: "2" },
      { idTag: "3", idActiveNote: "3" },
      { idTag: "3-1", idActiveNote: "1" },
      { idTag: "3-2", idActiveNote: "1" },
      { idTag: "3-2-1", idActiveNote: "1" },
      { idTag: "3-2-2", idActiveNote: "1" },
      { idTag: "4", idActiveNote: "1" },
      { idTag: "5", idActiveNote: "1" },
      { idTag: "6", idActiveNote: "1" },
      { idTag: "7", idActiveNote: "1" },
      { idTag: "8", idActiveNote: "1" },
      { idTag: "9", idActiveNote: "1" },
      { idTag: "10", idActiveNote: "1" },
    ];
  }
  //console.table(activatedNotes);
  return activatedNotes;
}

function saveCurrentActivatedNotes() {
  //console.log("selectedTag.value.id " + selectedTag.value.id);
  //console.log("activatedNotes " + JSON.stringify(activatedNotes.value));

  const index = activatedNotes.value.findIndex(
    (obj) => obj.idTag == selectedTag.value.id
  );
  const currentNote = activatedNotes.value[index];
  currentNote.idActiveNote = selectedNote.value;

  //console.log("currentNote: " + JSON.stringify(currentNote));
}

function getActivatedNoteNewTag(tag) {
  const note = activatedNotes.value.find((obj) => {
    return obj.idTag === tag.id;
  });
  //console.log("activatedNotes: " + JSON.stringify(activatedNotes));
  //console.log("tag: " + JSON.stringify(tag));
  console.log("NOTE: " + JSON.stringify(note));
  console.log("activatedNotes.value " + JSON.stringify(activatedNotes.value));
  return note.idActiveNote;
}

const emit = defineEmits(["update"]);

onMounted(() => {
  emit("update", findNoteById(selectedNote.value));
});

const insideModel = ref(40);

const selectedTag = ref({ id: "1" });
const selectedNote = ref("1"); //notes[0].id

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
