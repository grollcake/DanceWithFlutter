var app = new Vue({
    el: '#app',
    data: {
        projects: [{ 'project': 'project-a', 'author': 'unknown', 'github': 'https://github.com/grollcake/DanceWithFlutter' }],
        projectTitle: 'sample title',
        projectSource: 'https://github.com/grollcake/DanceWithFlutter/blob/master/Era/_1014_verification',

    },
    mounted: function () {
        this.getProjectsList()
    },
    methods: {
        getProjectsList: function () {
            axios.get("/projects.json").then((response) => {
                console.log(response.data);
                this.projects = response.data;
            })
        },
        showDetail: function (project) {
            this.projectTitle = project;
            var myModal = new bootstrap.Modal(document.getElementById('detailView'), {});
            myModal.show();
        },
    }
});
