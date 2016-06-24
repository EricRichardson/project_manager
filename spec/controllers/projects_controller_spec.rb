require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  def create_project
    Project.create(FactoryGirl.attributes_for(:project))
  end

  let (:user) { create(:user)}
  let (:sign_in) { request.session[:user_id] = User.last.id}

  describe "#new" do
    context "the user is not signed in" do
      it "redirects to the sign in page" do
        get :new
        expect(response).to redirect_to(new_session_path)
      end
    end

    context "the user is signed in" do

      before {user; sign_in; get :new}

      it "sets an instance variable to a new project" do
        expect(assigns(:project)).to be_a_new(Project)
      end

      it "renders the new template" do
        expect(response).to render_template(:new)
      end
    end
  end

  describe "#create" do

     context "with valid params" do
        def valid_project
          post :create, project: FactoryGirl.attributes_for(:project)
        end

        it "should save the project" do
          count_before = Project.count
          valid_project
          count_after = Project.count
          expect(count_after).to eq(count_before + 1)
        end

        it "should redirect to show project" do
          valid_project
          expect(response).to redirect_to(project_path(Project.last.id))
        end
      end

    context "with invalid params" do
      def invalid_project
        post :create, project: {title: ''}
      end

      it "should not make the project" do
        count_before = Project.count
        invalid_project
        count_after = Project.count
        expect(count_before).to eq(count_after)
      end

      it "should render new" do
        invalid_project
        expect(response).to render_template(:new)
      end
    end
  end

  describe "#show" do
    before do
      create_project
      get :show, id: Project.last.id
    end

    it "should initialize a variable according to passed id" do
      expect(assigns(:project)).to eq(Project.last)
    end

    it "should render the show template" do
      expect(response).to render_template(:show)
    end
  end

  describe "#index" do
    before do
      @p1 = create_project
      @p2 = create_project
      get :index
    end

    it "instantiates a variable of the projects" do
      expect(assigns(:projects)).to eq([@p2, @p1])
    end

    it "renders the index template" do
      expect(response).to render_template(:index)
    end
  end

  describe "#edit" do

   context "the user is not signed in" do
      before { create_project; get :edit, id: Project.last.id}
      it "should redirect to the sign in page" do
        expect(response).to redirect_to new_session_path
      end
    end

    context "the user is signed in" do
      before { user; sign_in; create_project; get:edit, id: Project.last.id}
      it "instantiates a variable according to passed id" do
        expect(assigns(:project)).to eq(Project.last)
      end

      it "should render the edit template" do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "#update" do

    def project
      @project ||= Project.create FactoryGirl.attributes_for(:project)
    end
    context "with valid params" do

      it "should update the project" do
        patch :update, id: project.id, project: {title: "new"}
        expect(Project.last.title).to eq("new")
      end

      it "should redirect to show" do
        patch :update, id: project.id, project: {title: "new"}
        expect(response).to redirect_to(project_path(project))
      end
    end

    context "with invalid params" do
      it "should not update the project" do
        patch :update, id: project.id, project: {title: ""}
        expect(Project.last.title).to_not eq('')
      end

      it "should render edit" do
        patch :update, id: project.id, project: {title: ""}
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "#destroy" do
    before {create_project}
    it "should destroy the project" do
      count_before = Project.count
      delete :destroy, id: Project.last.id
      count_after = Project.count
      expect(count_before).to eq(count_after + 1)
    end

    it "should redirect to index" do
      delete :destroy, id: Project.last.id
      expect(response).to redirect_to(projects_path)
    end
  end
end
