"""Official cloth/self/material fixture with actual Newton full-surface ground contacts."""
import json

import newton
import numpy as np

from reconstruction.csrc.self_material_cloth_contact_scene import Example as BaseExample


class Example(BaseExample):
    def __init__(self, viewer, args):
        super().__init__(viewer, args)
        self.pipeline = newton.CollisionPipeline(self.model, enable_rigid_soft_full_surface_contact=True)
        self.contacts = self.pipeline.contacts()
        self.checked_first_contacts = False

    def step(self):
        self.state_0.clear_forces()
        self.pipeline.collide(self.state_0, self.contacts)
        if not self.checked_first_contacts:
            count = int(self.contacts.soft_contact_count.numpy()[0])
            assert 0 < count <= self.contacts.soft_contact_max
            indices = self.contacts.soft_contact_indices.numpy()[:count]
            weights = self.contacts.soft_contact_barycentric.numpy()[:count]
            non_vertex = sum(len(set(ids[np.abs(w) > 0].tolist())) > 1 for ids, w in zip(indices, weights))
            print('full_surface_first_contacts '+json.dumps({'count': count, 'non_vertex': int(non_vertex)}), flush=True)
            self.checked_first_contacts = True
        self.solver.step(self.state_0, self.state_1, self.control, self.contacts, 1/240)
        self.state_0, self.state_1 = self.state_1, self.state_0
